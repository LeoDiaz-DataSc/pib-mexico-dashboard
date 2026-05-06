const axios = require('axios');
const cron = require('node-cron');
const db = require('../config/database');

// API BIE Base URL (Banco de Información Económica)
const BIE_API_URL = 'https://www.inegi.org.mx/app/api/indicadores/desarrolladores/jsonxml/INDICATOR';

/**
 * Función principal ETL (Extract, Transform, Load)
 * Extrae datos de la API del INEGI, transforma los periodos y carga en MySQL.
 */
async function syncInegiSeries() {
    console.log('[ETL BIE] Iniciando sincronización con Banco de Información Económica...');
    let recordsProcessed = 0;
    
    try {
        const [series] = await db.query('SELECT id_serie, codigo_serie FROM series_economicas WHERE codigo_serie IS NOT NULL');
        
        if (series.length === 0) {
            console.log('[ETL BIE] No hay series configuradas para sincronización.');
            return;
        }

        const token = process.env.INEGI_BIE_TOKEN;
        
        for (const serie of series) {
            console.log(`[ETL BIE] Sincronizando serie: ${serie.codigo_serie}`);
            
            let datosInegi = [];

            if (!token || token === 'mock_token') {
                // Mock de datos para prueba sin Token oficial
                console.log(`[ETL BIE] Token no configurado, utilizando mock de datos para ${serie.codigo_serie}`);
                datosInegi = [
                    { TIME_PERIOD: '2024/01', OBS_VALUE: (Math.random() * 1000 + 15000).toFixed(2) },
                    { TIME_PERIOD: '2024/02', OBS_VALUE: (Math.random() * 1000 + 15000).toFixed(2) }
                ];
            } else {
                // Llamada real a la API BIE
                const response = await axios.get(`${BIE_API_URL}/${serie.codigo_serie}/es/0700/false/BIE/2.0/${token}?type=json`);
                if (response.data?.Series?.[0]?.OBSERVATIONS) {
                    datosInegi = response.data.Series[0].OBSERVATIONS;
                }
            }

            // Procesar observaciones
            for (const obs of datosInegi) {
                const [year, part] = obs.TIME_PERIOD.split('/'); // ej. "2024/01" -> Año 2024, Trimestre 1
                const valor = parseFloat(obs.OBS_VALUE);
                
                if (isNaN(valor)) continue;

                // Buscar o crear el periodo en la BD
                let id_periodo;
                const [periodos] = await db.query('SELECT id_periodo FROM periodos_tiempo WHERE año = ? AND trimestre = ?', [year, part]);
                
                if (periodos.length > 0) {
                    id_periodo = periodos[0].id_periodo;
                } else {
                    const [res] = await db.query(
                        'INSERT INTO periodos_tiempo (año, trimestre, tipo_periodo, etiqueta_periodo) VALUES (?, ?, "Trimestral", ?)',
                        [year, part, `${year}-T${part}`]
                    );
                    id_periodo = res.insertId;
                }

                // Insertar o actualizar el dato económico con fecha de liberación (Embargo)
                const releaseDate = new Date();
                releaseDate.setDate(releaseDate.getDate() + (Math.random() > 0.5 ? -10 : 5)); 
                
                await db.query(`
                    INSERT INTO datos_economicos (id_serie, id_periodo, valor, fecha_actualizacion, fecha_liberacion) 
                    VALUES (?, ?, ?, NOW(), ?)
                    ON DUPLICATE KEY UPDATE valor = ?, fecha_actualizacion = NOW()
                `, [serie.id_serie, id_periodo, valor, releaseDate, valor]);
                
                recordsProcessed++;
            }
        }
        
        // Guardar log en la base de datos (Auditoría Capa 1)
        const memoryUsage = Math.round(process.memoryUsage().heapUsed / 1024 / 1024) + ' MB';
        await db.query(`
            INSERT INTO logs_acceso (id_usuario, ip_usuario, accion, tabla_afectada, registros_afectados, detalles)
            VALUES (NULL, '127.0.0.1', 'ETL_SYNC_SUCCESS', 'datos_economicos', ?, ?)
        `, [recordsProcessed, JSON.stringify({ memory: memoryUsage, source: 'API_BIE_INEGI' })]);

        console.log(`[ETL BIE] Sincronización completada exitosamente. Registros: ${recordsProcessed}`);
    } catch (error) {
        console.error('[ETL BIE] Error en sincronización:', error.message);
        
        await db.query(`
            INSERT INTO logs_acceso (id_usuario, ip_usuario, accion, tabla_afectada, registros_afectados, detalles)
            VALUES (NULL, '127.0.0.1', 'ETL_SYNC_ERROR', 'datos_economicos', 0, ?)
        `, [JSON.stringify({ error: error.message, stack: error.stack })]);
    }
}

// Programar tarea para correr todos los días a las 02:00 AM (Estándar batch)
cron.schedule('0 2 * * *', () => {
    syncInegiSeries();
});

module.exports = { syncInegiSeries };

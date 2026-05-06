const express = require('express');
const router = express.Router();
const db = require('../config/database');
const { create } = require('xmlbuilder2');

/**
 * GET /api/export/sdmx
 * Genera el archivo XML en formato SDMX para interoperabilidad institucional (FMI / Eurostat)
 */
router.get('/sdmx', async (req, res) => {
    try {
        // En un entorno de producción (Módulo de Embargo), solo exportaríamos datos ya liberados
        const [rows] = await db.query(`
            SELECT 
                s.codigo_serie, 
                p.año, 
                p.trimestre, 
                de.valor
            FROM datos_economicos de
            JOIN series_economicas s ON de.id_serie = s.id_serie
            JOIN periodos_tiempo p ON de.id_periodo = p.id_periodo
            WHERE de.fecha_liberacion <= NOW() OR de.fecha_liberacion IS NULL
            ORDER BY s.codigo_serie, p.año, p.trimestre
        `);

        // Estructura base SDMX-ML (Statistical Data and Metadata eXchange)
        const doc = create({ version: '1.0', encoding: 'UTF-8' })
            .ele('message:GenericData', {
                'xmlns:message': 'http://www.sdmx.org/resources/sdmxml/schemas/v2_1/message',
                'xmlns:generic': 'http://www.sdmx.org/resources/sdmxml/schemas/v2_1/data/generic'
            })
                .ele('message:Header')
                    .ele('message:ID').txt(`INEGI_EXPORT_${Date.now()}`).up()
                    .ele('message:Test').txt('false').up()
                    .ele('message:Prepared').txt(new Date().toISOString()).up()
                    .ele('message:Sender', { id: 'INEGI_MX' }).up()
                .up()
                .ele('message:DataSet');

        let currentSeries = null;
        let seriesEle = null;

        for (const row of rows) {
            if (currentSeries !== row.codigo_serie) {
                currentSeries = row.codigo_serie;
                seriesEle = doc.ele('generic:Series')
                    .ele('generic:SeriesKey')
                        .ele('generic:Value', { id: 'INDICATOR', value: row.codigo_serie }).up()
                    .up();
            }

            seriesEle.ele('generic:Obs')
                .ele('generic:ObsDimension', { value: `${row.año}-Q${row.trimestre}` }).up()
                .ele('generic:ObsValue', { value: row.valor }).up()
            .up();
        }

        const xml = doc.end({ prettyPrint: true });

        res.header('Content-Type', 'application/xml');
        res.attachment(`inegi_data_sdmx_${Date.now()}.xml`);
        res.send(xml);

    } catch (error) {
        console.error('Error generando SDMX:', error.message);
        res.status(500).json({ success: false, message: 'Error generando exportación SDMX' });
    }
});

module.exports = router;

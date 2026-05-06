const express = require('express');
const router = express.Router();
const db = require('../config/database');

// GET economic data with filtering
router.get('/', async (req, res, next) => {
    try {
        const { serieId, startYear, endYear, subsectorId } = req.query;
        
        let query = `
            SELECT 
                de.id_dato,
                de.valor,
                de.valor_sin_tendencia,
                p.año,
                p.trimestre,
                p.etiqueta_periodo,
                s.codigo_serie,
                s.nombre as serie_nombre,
                su.nombre as subsector_nombre
            FROM datos_economicos de
            JOIN periodos_tiempo p ON de.id_periodo = p.id_periodo
            JOIN series_economicas s ON de.id_serie = s.id_serie
            LEFT JOIN subsectores su ON de.id_subsector = su.id_subsector
            WHERE (de.fecha_liberacion <= NOW() OR de.fecha_liberacion IS NULL)
        `;
        
        const params = [];
        
        if (serieId) {
            query += ` AND de.id_serie = ?`;
            params.push(serieId);
        }
        
        if (startYear) {
            query += ` AND p.año >= ?`;
            params.push(startYear);
        }
        
        if (endYear) {
            query += ` AND p.año <= ?`;
            params.push(endYear);
        }
        
        if (subsectorId) {
            query += ` AND de.id_subsector = ?`;
            params.push(subsectorId);
        }
        
        query += ` ORDER BY p.año DESC, p.trimestre DESC LIMIT 1000`;
        
        const [data] = await db.query(query, params);
        res.json({ success: true, count: data.length, data });
    } catch (err) {
        next(err);
    }
});

module.exports = router;

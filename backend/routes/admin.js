const express = require('express');
const router = express.Router();
const db = require('../config/database');
const { verifyToken, checkRole } = require('../middleware/auth');

/**
 * GET /api/admin/logs
 * Devuelve la bitácora de accesos para auditoría ISO 27001.
 */
router.get('/logs', verifyToken, checkRole('admin'), async (req, res) => {
    try {
        const [rows] = await db.query(`
            SELECT l.id_log, l.fecha_accion, l.ip_usuario, l.accion, l.tabla_afectada, u.nombre_usuario, u.tipo_usuario
            FROM logs_acceso l
            LEFT JOIN usuarios u ON l.id_usuario = u.id_usuario
            ORDER BY l.fecha_accion DESC LIMIT 100
        `);
        res.json({ success: true, data: rows });
    } catch (error) {
        console.error('Error fetching logs:', error.message);
        res.status(500).json({ error: 'Error obteniendo bitácora de accesos' });
    }
});

/**
 * GET /api/admin/cron-logs
 * Devuelve el historial de ejecuciones del scheduler ETL.
 */
router.get('/cron-logs', verifyToken, checkRole('admin'), async (req, res) => {
    try {
        const [rows] = await db.query(`
            SELECT id_log, fecha_accion, accion, registros_afectados, detalles
            FROM logs_acceso 
            WHERE accion IN ('ETL_SYNC_SUCCESS', 'ETL_SYNC_ERROR')
            ORDER BY fecha_accion DESC LIMIT 50
        `);
        res.json({ success: true, data: rows });
    } catch (error) {
        console.error('Error fetching cron logs:', error.message);
        res.status(500).json({ error: 'Error obteniendo historial del ETL' });
    }
});

module.exports = router;

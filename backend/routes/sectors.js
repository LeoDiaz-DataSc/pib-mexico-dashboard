const express = require('express');
const router = express.Router();
const db = require('../config/database');

// GET all sectors
router.get('/', async (req, res, next) => {
    try {
        const [sectors] = await db.query('SELECT * FROM sectores_economicos WHERE activo = TRUE');
        res.json({ success: true, count: sectors.length, data: sectors });
    } catch (err) {
        next(err);
    }
});

// GET subsectors by sector
router.get('/:id/subsectors', async (req, res, next) => {
    try {
        const { id } = req.params;
        const [subsectors] = await db.query(
            'SELECT * FROM subsectores WHERE id_sector = ? AND activo = TRUE ORDER BY orden_presentacion',
            [id]
        );
        res.json({ success: true, count: subsectors.length, data: subsectors });
    } catch (err) {
        next(err);
    }
});

module.exports = router;

const express = require('express');
const router = express.Router();
const db = require('../config/database');

// GET all economic series
router.get('/', async (req, res, next) => {
    try {
        const [series] = await db.query('SELECT * FROM series_economicas');
        res.json({ success: true, count: series.length, data: series });
    } catch (err) {
        next(err);
    }
});

// GET specific series
router.get('/:id', async (req, res, next) => {
    try {
        const { id } = req.params;
        const [series] = await db.query('SELECT * FROM series_economicas WHERE id_serie = ?', [id]);
        if (series.length === 0) {
            return res.status(404).json({ success: false, error: 'Series not found' });
        }
        res.json({ success: true, data: series[0] });
    } catch (err) {
        next(err);
    }
});

module.exports = router;

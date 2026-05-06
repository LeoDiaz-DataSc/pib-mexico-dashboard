const express = require('express');
const router = express.Router();
const db = require('../config/database');
const speakeasy = require('speakeasy');
const QRCode = require('qrcode');

/**
 * Genera un secreto MFA para el usuario y retorna el código QR.
 * Requiere que el usuario ya esté autenticado (simulado con user_id).
 */
router.post('/mfa/setup', async (req, res) => {
    const { user_id } = req.body;
    
    if (!user_id) return res.status(400).json({ error: 'Falta user_id' });

    try {
        const secret = speakeasy.generateSecret({ name: 'INEGI_Dashboard_MFA' });
        
        await db.query('UPDATE usuarios SET mfa_secret = ? WHERE id_usuario = ?', [secret.base32, user_id]);
        
        QRCode.toDataURL(secret.otpauth_url, (err, data_url) => {
            if (err) throw err;
            res.json({ success: true, secret: secret.base32, qr_code: data_url });
        });
    } catch (error) {
        console.error('Error MFA Setup:', error);
        res.status(500).json({ error: 'Error interno' });
    }
});

/**
 * Verifica el token MFA para activar la seguridad 2FA.
 */
router.post('/mfa/verify', async (req, res) => {
    const { user_id, token } = req.body;

    try {
        const [users] = await db.query('SELECT mfa_secret FROM usuarios WHERE id_usuario = ?', [user_id]);
        if (users.length === 0) return res.status(404).json({ error: 'Usuario no encontrado' });

        const verified = speakeasy.totp.verify({
            secret: users[0].mfa_secret,
            encoding: 'base32',
            token: token
        });

        if (verified) {
            await db.query('UPDATE usuarios SET mfa_enabled = TRUE WHERE id_usuario = ?', [user_id]);
            res.json({ success: true, message: 'MFA activado correctamente' });
        } else {
            res.status(401).json({ success: false, message: 'Token inválido' });
        }
    } catch (error) {
        console.error('Error MFA Verify:', error);
        res.status(500).json({ error: 'Error interno' });
    }
});

module.exports = router;

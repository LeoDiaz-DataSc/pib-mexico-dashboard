const jwt = require('jsonwebtoken');
const JWT_SECRET = process.env.JWT_SECRET || 'inegi_default_secret_2026';

const verifyToken = (req, res, next) => {
    const authHeader = req.headers['authorization'];
    if (!authHeader) return res.status(403).json({ error: 'No token provided' });

    const token = authHeader.split(' ')[1];
    
    jwt.verify(token, JWT_SECRET, (err, decoded) => {
        if (err) return res.status(401).json({ error: 'Unauthorized' });
        req.user = decoded;
        next();
    });
};

const checkRole = (...roles) => {
    return (req, res, next) => {
        if (!req.user || !roles.includes(req.user.rol)) {
            return res.status(403).json({ error: 'Requiere permisos superiores' });
        }
        next();
    };
};

module.exports = { verifyToken, checkRole };

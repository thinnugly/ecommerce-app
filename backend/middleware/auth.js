const jwt = require("jsonwebtoken");

const TOKEN_KEY = "RANDOM_KEY";

function authenticationToken(req, res, next) {
    const authHeader = req.headers['authorization'];
    
    // Verifica se o header existe e começa com 'Bearer'
    if (!authHeader || !authHeader.startsWith('Bearer ')) {
        return res.status(401).json({
            message: "Token não encontrado",
            details: "O header 'Authorization' deve conter um token no formato 'Bearer {token}'",
            statusCode: 401
        });
    }

    const token = authHeader.split(' ')[1]; // Pega apenas o token

    jwt.verify(token, TOKEN_KEY, (err, user) => {
        if (err) {
            return res.status(403).json({
                message: "Token inválido ou expirado",
                details: err.message,
                statusCode: 403
            });
        }
        req.user = user;
        next();
    });
}

function generateAccessToken(userModel) {
    return jwt.sign({ data: userModel }, TOKEN_KEY, {
        expiresIn: "1h"
    });
}

module.exports = {
    authenticationToken,
    generateAccessToken,
}
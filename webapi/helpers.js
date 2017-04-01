'use strict';
var logger = require('./logger');
var tags = require('./config').logger.tags;
var authenticationServices = require('./dataProvider').services.authentication;

var pathsToNotValidate = ['/api/login', '/api/register'];

var verifyAuthentication = function(request, reply) {
    var url = request.url.path;
    var cookie = request.headers['x-cookie'];
    logger.log(`${url} - ${cookie}`, tags.REQUEST);

    if (pathsToNotValidate.indexOf(url) >= 0) {
        return reply.continue();
    } else {
        var errorResponse = {
            error: {
                type: 'Identity.Unauthorized',
                message: 'Unauthorized'
            }
        };
        authenticationServices.checkSessions(cookie)
            .then(function(sessionDataResult) {
                if (sessionDataResult && Array.isArray(sessionDataResult) && sessionDataResult.length === 1) {
                    return reply.continue();
                } else {
                    return reply(errorResponse);
                }
            })
            .catch(function(error) {
                return reply(errorResponse);
            });
    }
}

module.exports = {
    verifyAuthentication
}

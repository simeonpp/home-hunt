'use strict';
var logger = require('../logger');
var tags = require('../config').logger.tags;
var errorHandler = require('../errorHandler');
var authenticationServices = require('../dataProvider').services.authentication;

var register = {
    handler: function(request, reply) {
        logger.log(`register - ${request.payload.username}`, tags.REQUEST);
    }
}

var login = {
    handler: function(request, reply) {
        logger.log(`login - ${request.payload.username}`, tags.REQUEST);
        var username = request.payload.username;
        var password = request.payload.password;

        var userId;
        authenticationServices.login(username, password)
            .then(function(loginResult) {
                userId = loginResult.id;
                return authenticationServices.deleteSession(userId);
            })
            .then(function(deleteSessionResult) {
                return authenticationServices.createSession(userId);
            })
            .then(function(sessionCreationResult) {
                return reply(sessionCreationResult);
            })
            .catch(function(error) {
                reply({
                    error: {
                        type: 'invalid.credentials',
                        message: 'Invalid credentials'
                    }
                });
            })
    }
}

var logout = {
    handler: function(request, reply) {
        logger.log(`logout - ${request.headers['x-cookie']}`, tags.REQUEST);
        var cookie = request.headers['x-cookie'];

        if (cookie) {
            authenticationServices.deleteSessionByCookie(cookie)
                .then(function(deleteSessionResult) {
                    return reply({success: true});
                })
                .catch(function(error) {
                    reply({
                        error: {
                            type: 'invalid.credentials',
                            message: 'Invalid credentials'
                        }
                    });
                })
        } else {
            reply({})
        }
    }
}

module.exports = {
    register,
    login,
    logout
}
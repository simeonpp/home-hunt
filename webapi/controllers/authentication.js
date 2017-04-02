'use strict';
var authenticationServices = require('../dataProvider').services.authentication;

var register = {
    handler: function(request, reply) {
        var username = request.payload.username;
        var password = request.payload.password;

        authenticationServices.register(username, password)
            .then(function(registerResult) {
                return reply(registerResult);
            })
            .catch(function(error) {
                reply({error: true})
            })
    }
};

var login = {
    handler: function(request, reply) {
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
};

var logout = {
    handler: function(request, reply) {
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
};

module.exports = {
    register,
    login,
    logout
}
'use strict';
var config = require('./config');
var dataProviderConnection = require('./dataProvider/connection');
var errorHandler = require('./errorHandler');
var routes = require('./routes');
var logger = require('./logger');
var helpers = require('./helpers');

const Hapi = require('hapi');

dataProviderConnection.init
    .then(function(dataProviderConnectionResult) {
        const server = new Hapi.Server();
        server.connection({ port: config.application.port, host: config.application.host });
        server.route(routes.endpoints);
        server.ext('onRequest', helpers.verifyAuthentication);
        server.start(function() {
            logger.logHeader(`Server started at ${server.info.uri}`, config.logger.tags.SYSTEM)
        });
    })
    .catch(function(error) {
        errorHandler.handleError(error);
    });

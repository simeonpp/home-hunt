'use strict';

var config = require('./config');
var authenticationController = require('./controllers/authentication');
var logger = require('./logger');

const apiEndpoints = [
    { method: 'POST', path: '/register', config: authenticationController.register },
    { method: 'POST', path: '/login', config: authenticationController.login },
    { method: 'POST', path: '/logout', config: authenticationController.logout }
].map(function(endpoint) { // add api url prefix to each route path
    endpoint.path = `${config.application.apiUrl}${endpoint.path}`
    return endpoint
});

const clientEndpoints = [];

const endpoints = apiEndpoints.concat(clientEndpoints);

// Notify
logger.logHeader("Registered endpoints:", config.logger.tags.SYSTEM)
endpoints.forEach(function(endpoint) {
    logger.log(`[${endpoint.method}] ${endpoint.path}`, config.logger.tags.SYSTEM)
});

module.exports = {
    endpoints
};

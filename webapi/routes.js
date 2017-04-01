'use strict';

var config = require('./config');
var controllers = require('./controllers');
var logger = require('./logger');

const apiEndpoints = [
    // Authentication
    { method: 'POST', path: '/register', config: controllers.authentication.register },
    { method: 'POST', path: '/login', config: controllers.authentication.login },
    { method: 'POST', path: '/logout', config: controllers.authentication.logout },

    // Agents
    { method: 'GET', path: '/agents', config: controllers.agent.getAll },
    { method: 'GET', path: '/agents/{id}', config: controllers.agent.getById },

    // Adds
    { method: 'GET', path: '/adds', config: controllers.add.getAll },
    { method: 'GET', path: '/adds/{id}', config: controllers.add.getById }
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

var authenticationController = require('./authentication');
var agentController = require('./agent');
var addController = require('./add');

module.exports = {
    authentication: authenticationController,
    agent: agentController,
    add: addController
};

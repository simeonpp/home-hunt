var staticController = require('./static');
var authenticationController = require('./authentication');
var agentController = require('./agent');
var addController = require('./add');
var appointmentController = require('./appointment');
var reviewController = require('./review');

module.exports = {
    static: staticController,
    authentication: authenticationController,
    agent: agentController,
    add: addController,
    appointment: appointmentController,
    review: reviewController
};

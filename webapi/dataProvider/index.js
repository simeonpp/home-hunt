'use strict';

var authenticationServices = require('./services/authentication');
var agentServices = require('./services/agent');
var noteServices = require('./services/notes');
var addServices = require('./services/adds');
var imageServices = require('./services/images');
var addAttributeServices = require('./services/addAttributes');
var appointmentAttributeServices = require('./services/appointment');

module.exports = {
    services: {
        authentication: authenticationServices,
        agent: agentServices,
        note: noteServices,
        add: addServices,
        image: imageServices,
        addAttribute: addAttributeServices,
        appointment: appointmentAttributeServices
    }
};
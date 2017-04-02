'use strict';

var authenticationServices = require('./services/authentication');
var agentServices = require('./services/agent');
var noteServices = require('./services/notes');
var addServices = require('./services/adds');
var imageServices = require('./services/images');
var addAttributeServices = require('./services/addAttributes');

module.exports = {
    services: {
        authentication: authenticationServices,
        agent: agentServices,
        note: noteServices,
        add: addServices,
        image: imageServices,
        addAttribute: addAttributeServices
    }
};
'use strict';
var errors = require('../errors');
var helpers = require('./helpers');

var dataServices = require('../dataProvider').services;
var agentServices = dataServices.agent;
var noteServices = dataServices.note;

var getAll = {
    handler: function(request, reply) {
        agentServices.getAll()
            .then(function(agents) {
                // Calculate rating
                agents = agents.map(function(agent) {
                    helpers.mapRating(agent);
                    return agent;
                });
                reply({
                    result: agents
                });
            })
            .catch(function(error) {
                reply({ error: errors.getError() }); // default error
            });
    }
};

var getById = {
    handler: function(request, reply) {
        var agentId = request.params.id;

        var agent;
        agentServices.getById(agentId)
            .then(function(agentData) {
                helpers.mapRating(agentData);
                agent = agentData;
                return noteServices.getByAgentId(agent.id);
            })
            .then(function(agentNotesData) {
                agent.notes = agentNotesData;
                var resultToReturn = {
                    result: agent
                }
                reply(resultToReturn);
            })
            .catch(function(error) {
                reply({ error: errors.getError() }); // default error
            });
    }
};

module.exports = {
    getAll,
    getById
}

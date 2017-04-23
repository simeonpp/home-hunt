'use strict';
var errors = require('../errors');
var helpers = require('./helpers');

var dataServices = require('../dataProvider').services;
var appointmentServices = dataServices.appointment;
var agentServices = dataServices.agent;

var getAll = {
    handler: function(request, reply) {
        appointmentServices.getAll()
            .then(function(appointments) {
                appointments = appointments.map(function(app) {
                    app.date = helpers.formatDate(app.date);
                    return app;
                });
                reply({
                    result: appointments
                });
            })
            .catch(function(error) {
                reply({ error: errors.getError() }); // default error
            });
    }
};

var getById = {
    handler: function(request, reply) {
        var appointmentId = request.params.id;

        var appointment;
        appointmentServices.getById(appointmentId)
            .then(function(appointmentData) {
                appointmentData.date = helpers.formatDate(appointmentData.date);
                reply({
                    result: appointmentData
                });
            })
            .catch(function(error) {
                reply({ error: errors.getError() }); // default error
            });
    }
};

var create = {
    handler: function(request, reply) {
        var addId = request.payload.id;
        var dateAndTime = request.payload.dateAndTime;
        var note = request.payload.note;

        agentServices.getAgentIdByAddId(addId)
            .then(function(agentId) {
                return appointmentServices.create(addId, agentId, dateAndTime, note)
            })
            .then(function(appointmentCreateResult) {
                reply(appointmentCreateResult);
            })
            .catch(function(error) {
                if (error.type) {
                    reply(error);
                }
                reply({ error: errors.getError() }); // default error
            });
    }
}

var deleteById = {
    handler: function(request, reply) {
        var appointmentId = request.params.id;

        appointmentServices.deleteById(appointmentId)
            .then(function(appointmentDeleteResult) {
                reply(appointmentDeleteResult);
            })
            .catch(function(error) {
                if (error.type) {
                    reply(error);
                }
                reply({ error: errors.getError() }); // default error
            });
    }
}

var updateById = {
    handler: function(request, reply) {
        var appointmentId = request.params.id;
        var timestamp = request.payload.timestamp;
        var note = request.payload.note

        appointmentServices.updateById(appointmentId, timestamp, note)
            .then(function(appointmentUpdateResult) {
                reply(appointmentUpdateResult);
            })
            .catch(function(error) {
                if (error.type) {
                    reply(error);
                }
                reply({ error: errors.getError() }); // default error
            });
    }
}

module.exports = {
    getAll,
    getById,
    create,
    deleteById,
    updateById
}

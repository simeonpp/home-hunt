'use strict';
var errors = require('../errors');

var dataServices = require('../dataProvider').services;
var agentServices = dataServices.agent;
var addServices = dataServices.add;
var noteServices = dataServices.note;
var appointmentServices = dataServices.appointment;

var addReview = {
    handler: function(request, reply) {
        var appointmentId = request.params.id;
        var addId = request.payload.addId;
        var addRating = request.payload.addRating;
        var addNote = request.payload.addNote;

        var agentId = request.payload.addId;
        var agentRating = request.payload.agentRating;
        var agentNote = request.payload.agentNote;

        noteServices.create('add', addId, addNote)
            .then(function(addNoteAddResult) {
                return noteServices.create('agent', agentId, agentNote);
            })
            .then(function(addNoteAgentResult) {
                return addServices.updateRating(addId, addRating)
            })
            .then(function(updateAddRatingResult) {
                return agentServices.updateRating(agentId, agentRating);
            })
            .then(function(updateAgentRatingResult) {
                return appointmentServices.updateStatus(appointmentId, 1);
            })
            .then(function(updateAppointmentResult) {
                reply({ success: true });
            })
            .catch(function(error) {
                reply({ error: errors.getError() }); // default error
            });
    }
};

module.exports = {
    addReview
}

'use strict';
var errors = require('../errors');
var utils = require('../utils');
var helpers = require('./helpers');

var dataServices = require('../dataProvider').services;
var addServices = dataServices.add;
var noteServices = dataServices.note;
var imageServices = dataServices.image;
var addAttributeServices = dataServices.addAttribute;

var getAll = {
    handler: function(request, reply) {
        addServices.getAll()
            .then(function(adds) {
                // Calculate rating
                adds = adds.map(function(add) {
                    console.log(add);
                    helpers.mapRating(add);
                    return add;
                });
                reply(adds);
            })
            .catch(function(error) {
                reply({ error: errors.getError() }); // default error
            });
    }
};

var getById = {
    handler: function(request, reply) {
        var addId = request.params.id;

        var add,
            notes,
            images,
            attributes;

        addServices.getById(addId)
            .then(function(addData) {
                helpers.mapRating(addData);
                add = addData;
                return noteServices.getByAddId(add.id)
            })
            .then(function(addNotesData) {
                notes = addNotesData;
                return imageServices.getAllByAddId(add.id);
            })
            .then(function(addImagesData) {
                images = addImagesData;
                return addAttributeServices.getAllByAddId(add.id)
            })
            .then(function(addAttributesDate) {
                attributes = addAttributesDate;
                reply({
                    add,
                    images,
                    attributes,
                    notes
                });
            })
            .catch(function(error) {
                reply({ error: errors.getError() }); // default error
            })
    }
}

module.exports = {
    getAll,
    getById
}
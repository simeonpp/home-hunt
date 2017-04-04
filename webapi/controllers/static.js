'use strict';
var fs = require('fs');
var errors = require('../errors');
var applicationConfig = require('../config').application;

var getImage = {
    handler: function(request, reply) {
        var file = request.params.filename;
        var path = applicationConfig.publicUploadsFolder + file;
        // var extension = file.substr(file.lastIndexOf('.') + 1);
        fs.readFile(path, function(error, content) {
            if (error) {
                return reply("file not found");
            }

            return reply.file(path);
        });
    }
};

module.exports = {
    getImage
}

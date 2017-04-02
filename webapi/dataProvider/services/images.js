'use strict';

var connection;
var getConnection = function() {
    if (!connection) {
        connection = require('../connection').getConnection();
    }

    return connection;
}

var getAllByAddId = function(addId) {
    var promise = new Promise(function(resolve, reject) {
        var query = 'SELECT filename, contentType, extension, size, width, height, isMain ' +
                    'FROM adds_images ' +
                     `WHERE addId = ${addId}`;
        getConnection().query(query)
            .then(function(imagesDbResult) {
                resolve(imagesDbResult);
            })
            .catch(function(error) {
                reject(error);
            });
    });

    return promise;
}

module.exports = {
    getAllByAddId
}

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
        var query = 'SELECT aat.`type`, aat.display as displayName, aav.value ' +
                    'FROM adds_attribute_values aav ' +
                    'INNER JOIN adds_attribute_types aat ON aav.addAttributeTypeId = aat.id ' +
                     `WHERE aav.addId = ${addId}`;
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

'use strict';

var connection;
var getConnection = function() {
    if (!connection) {
        connection = require('../connection').getConnection();
    }

    return connection;
}

var getByTypeAndObjectId = function(type, objectId) {
    var promise = new Promise(function(resolve, reject) {
        var query = `SELECT * FROM notes ` +
                    `WHERE objectType = "${type}" AND objectId = ${objectId}`;
        getConnection().query(query)
            .then(function(notesDbResult) {
                resolve(notesDbResult);
            })
            .catch(function(error) {
                reject(error);
            });
    });

    return promise;
};

var getByAgentId = function(agentId) {
    return getByTypeAndObjectId('agent', agentId);
};

var getByAddId = function(addId) {
    return getByTypeAndObjectId('add', addId);
};

module.exports = {
    getByAgentId,
    getByAddId
}

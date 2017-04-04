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

var create = function(objectType, objectId, note) {
    var promise = new Promise(function(resolve, reject) {
        var query = 'INSERT INTO notes (objectType, objectId, note) '
                    + `VALUES ("${objectType}", ${objectId}, "${note}")`;

        getConnection().query(query)
            .then(function(createAppointmentResult) {
                if (createAppointmentResult && createAppointmentResult.affectedRows === 1) {
                    resolve({ success: true });
                } else {
                    reject();
                }
            })
            .catch(function(error) {
                reject(error);
            })
    });

    return promise;
}

var getByAgentId = function(agentId) {
    return getByTypeAndObjectId('agent', agentId);
};

var getByAddId = function(addId) {
    return getByTypeAndObjectId('add', addId);
};

module.exports = {
    getByAgentId,
    getByAddId,
    create
}

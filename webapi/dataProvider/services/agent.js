'use strict';

var connection;
var getConnection = function() {
    if (!connection) {
        connection = require('../connection').getConnection();
    }

    return connection;
}

var getAll = function() {
    var promise = new Promise(function(resolve, reject) {
        var query = 'SELECT * FROM agents ORDER BY dateCreated DESC';
        getConnection().query(query)
            .then(function(agentGetResults) {
                resolve(agentGetResults);
            })
            .catch(function(error) {
                reject(error);
            })
    });

    return promise;
};

var getById = function(agentId) {
    var promise = new Promise(function(resolve, reject) {
        var query = `SELECT * FROM agents WHERE id = ${agentId}`;
        getConnection().query(query)
            .then(function(agentGetResult) {
                resolve(Object.assign({}, agentGetResult[0]));
            })
            .catch(function(error) {
                reject(error);
            })
    });

    return promise;
};

module.exports = {
    getAll,
    getById
}

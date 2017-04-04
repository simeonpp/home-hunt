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

var getAgentIdByAddId = function(addId) {
    var promise = new Promise(function(resolve, reject) {
        var query = `SELECT agentId FROM adds WHERE id = ${addId}`;
        getConnection().query(query)
            .then(function(getAgentIdResult) {
                var agentId = getAgentIdResult[0].agentId;
                resolve(agentId);
            })
            .catch(function(error) {
                reject(error);
            })
    });

    return promise;
}

var updateRating = function(agentId, newRatingToAdd){
    var promise = new Promise(function(resolve, reject) {
        // First get current rating
        var getAgentCurrentRatingQuery = `SELECT rating, ratingCount FROM agents WHERE id = ${agentId}`;

        getConnection().query(getAgentCurrentRatingQuery)
            .then(function(agentRatingResult) {
                var currentRating = agentRatingResult[0].rating;
                var currentRatingCount = agentRatingResult[0].ratingCount;

                var newRating = currentRating + newRatingToAdd;
                var newRatingCount = currentRatingCount + 1;

                var updateAgentRatingQuery = 'UPDATE agents ' +
                                            `SET rating = ${newRating}, ratingCount = ${newRatingCount} `+
                                            `WHERE id = ${agentId}`;
                return getConnection().query(updateAgentRatingQuery);
            })
            .then(function(updateRatingResult) {
                resolve({ success: true });
            })
            .catch(function(error) {
                console.log(error);
                reject(error);
            });
    });

    return promise;
}

module.exports = {
    getAll,
    getById,
    getAgentIdByAddId,
    updateRating
}

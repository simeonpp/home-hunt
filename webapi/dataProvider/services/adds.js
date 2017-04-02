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
        var query = 'SELECT a.id, addt.`type`, adds.display as `status`, a.rating, a.ratingCount, a.description, a.town, a.address, a.dateCreated, ' +
                    'agent.firstName as `agentFirstName`, agent.lastName as `agentLastName`, agent.phone as `agentPhone`, ' +
                    '(SELECT filename FROM adds_images addI WHERE addI.addId = a.id AND addI.isMain = 1 LIMIT 1) as imageFilename ' +
                    'FROM adds a ' + 
                    'INNER JOIN adds_types addt ON a.`type` = addt.id ' +
                    'INNER JOIN adds_statuses adds ON a.`status` = adds.id ' +
                    'INNER JOIN agents agent ON a.agentId = agent.id ' +
                    'ORDER BY dateCreated DESC';
        getConnection().query(query)
            .then(function(addGetResults) {
                resolve(addGetResults);
            })
            .catch(function(error) {
                reject(error);
            })
    });

    return promise;
};

var getById = function(addId) {
    var promise = new Promise(function(resolve, reject) {
        var query = 'SELECT a.id, addt.`type`, adds.display as `status`, a.rating, a.ratingCount, a.description, a.town, a.address, a.dateCreated, ' +
                        'agent.company as `agentCompany`, agent.phone as `agentPhone`, agent.email as `agentEmail`, agent.firstName as `agentFirstName`, ' +
                        'agent.id as `agentId`, agent.rating as `agentRating`, agent.ratingCount as `agentRatingCount`, agent.lastName as `agentLastName`, ' +
                        'agent.website as `agentWebsite` ' +
                    'FROM adds a ' +
                    'INNER JOIN adds_types addt ON a.`type` = addt.id ' +
                    'INNER JOIN adds_statuses adds ON a.`status` = adds.id ' + 
                    'INNER JOIN agents agent ON a.agentId = agent.id ' +
                    `WHERE a.id = "${addId}"`
        getConnection().query(query)
            .then(function(addGetResult) {
                resolve(Object.assign({}, addGetResult[0]));
            })
            .catch(function(error) {
                reject(error);
            })
    });

    return promise;
}

module.exports = {
    getAll,
    getById
}

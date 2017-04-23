'use strict';
var errors = require('../errors');

var connection;
var getConnection = function() {
    if (!connection) {
        connection = require('../connection').getConnection();
    }

    return connection;
}

var getAll = function() {
    var promise = new Promise(function(resolve, reject) {
        var query = 'SELECT ap.id, ap.addId, ap.agentId, ap.date, ap.note, aps.display as `status` ' +
                    'FROM appointments ap ' +
                    'INNER JOIN appointments_statuses aps ON aps.id = ap.status ' + 
                    'ORDER BY `date` DESC';
        getConnection().query(query)
            .then(function(appointmentGetResults) {
                resolve(appointmentGetResults);
            })
            .catch(function(error) {
                reject(error);
            })
    });

    return promise;
};

var getById = function(appointmentId) {
    var promise = new Promise(function(resolve, reject) {
        var query = 'SELECT ap.id, ap.addId, ap.agentId, ap.date, ap.note, aps.display as `status` ' +
                    'FROM appointments ap ' +
                    'INNER JOIN appointments_statuses aps ON aps.id = ap.status ' + 
                    `WHERE ap.id = ${appointmentId}`;
        getConnection().query(query)
            .then(function(appointmentGetResult) {
                resolve(Object.assign({}, appointmentGetResult[0]));
            })
            .catch(function(error) {
                reject(error);
            })
    });

    return promise;
};

var create = function(addId, agentId, dateAndTime, note) {
    var promise = new Promise(function(resolve, reject) {
        var query = 'INSERT INTO appointments (addId, agentId, `status`, `date`, note) '
                    + `VALUES (${addId}, ${agentId}, 3, '${dateAndTime}', "${note}")`

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

var deleteById = function(appointmentId) {
    var promise = new Promise(function(resolve, reject) {
        var query = `DELETE FROM appointments WHERE id = ${appointmentId}`;
        getConnection().query(query)
            .then(function(appointmentDeleteResult) {
                if (appointmentDeleteResult && appointmentDeleteResult.affectedRows === 1) {
                    resolve({ success: true });
                } else {
                    reject(errors.getError('PortMySQL.noSuchObject'));
                }
            })
            .catch(function(error) {
                console.log(error);
                reject(error);
            })
    });

    return promise;
};

var updateById = function(appointmentId, newDateAndTime, newNote) {
    var promise = new Promise(function(resolve, reject) {
        var query = 'UPDATE appointments ' +
                    'SET `date` = ' + newDateAndTime + ', note = "' + newNote + '" ' +
                    `WHERE id = ${appointmentId}`;
        getConnection().query(query)
            .then(function(appointmentDeleteResult) {
                if (appointmentDeleteResult && appointmentDeleteResult.affectedRows === 1) {
                    resolve({ success: true });
                } else {
                    reject(errors.getError('PortMySQL.noSuchObject'));
                }
            })
            .catch(function(error) {
                console.log(error);
                reject(error);
            })
    });

    return promise;
}

var updateStatus = function(appointmentId, newStatus) {
    var promise = new Promise(function(resolve, reject) {
        var query = 'UPDATE appointments ' +
                    'SET `status` = ' + newStatus + ' ' +
                    `WHERE id = ${appointmentId}`;
        getConnection().query(query)
            .then(function(appointmentDeleteResult) {
                if (appointmentDeleteResult && appointmentDeleteResult.affectedRows === 1) {
                    resolve({ success: true });
                } else {
                    reject(errors.getError('PortMySQL.noSuchObject'));
                }
            })
            .catch(function(error) {
                console.log(error);
                reject(error);
            })
    });

    return promise;
}

module.exports = {
    getAll,
    getById,
    create,
    deleteById,
    updateById,
    updateStatus
}

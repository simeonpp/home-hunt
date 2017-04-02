'use strict';
var errors = require('../errors');
var errorHandler = require('../../errorHandler');
var helpers = require('../helpers');
const uuidV4 = require('uuid/v4');

var connection;
var getConnection = function() {
    if (!connection) {
        connection = require('../connection').getConnection();
    }

    return connection;
}

var register = function(username, password) {
    var promise = new Promise(function(resolve, reject) {
        let query = `INSERT INTO users (username, password) VALUES ("${username}", "${password}")`;
        getConnection().query(query)
            .then(function(registerDbResult) {
                if (registerDbResult && registerDbResult.affectedRows === 1) {
                    // Simulate loading
                    setTimeout(function() {
                        resolve({
                            username: username
                        })
                    }, 2000)
                } else {
                    reject(errors.getError('PortMySQL.invalidResult'));
                }
            })
            .catch(function(error) {
                errorHandler.handleError(error);
            })
    });

    return promise;
};

var login = function(username, password) {    
    var promise = new Promise(function(resolve, reject) {
        let query = `SELECT id, username FROM users WHERE username = '${username}' AND password = '${password}'`;
        getConnection().query(query)
            .then(function(dataResult) {
                if (dataResult.length === 1) {
                    resolve(dataResult[0]);
                } else {
                    reject(errors.getError('PortMySQL.invalidResult'));
                }
            })
            .catch(function(error) {
                errorHandler.handleError(error);
            })
    });

    return promise;
};

var createSession = function(userId) {
    var promise = new Promise(function(resolve, reject) {
        var cookie = uuidV4();
        var now = new Date();
        var expiresDateAsTimestamp = now.setDate(now.getDate() + 3);
        var expiresDate = helpers.formatDate(new Date(expiresDateAsTimestamp));

        let query = 'INSERT INTO sessions (userId, cookie, expiresDate) ' +
                `VALUES ("${userId}", "${cookie}", "${expiresDate}");`;
        getConnection().query(query)
            .then(function(createSessionsResult) {
                if (createSessionsResult && createSessionsResult.affectedRows === 1) {
                    resolve({ cookie: cookie, expires: expiresDateAsTimestamp });
                } else {
                    reject(errors.getError('PortMySQL.invalidResult'));
                }
            })
            .catch(function(error) {
                errorHandler.handleError(error);
            });
    });

    return promise;
};

var deleteSession = function(userId) {
    var promise = new Promise(function(resolve, reject) {
        let query = `DELETE FROM sessions WHERE userId = ${userId}`;
        getConnection().query(query)
            .then(function(createSessionsResult) {
                resolve({});
            })
            .catch(function(error) {
                errorHandler.handleError(error);
            });
    });

    return promise;
};

var deleteSessionByCookie = function(cookie) {
    var promise = new Promise(function(resolve, reject) {
        let query = `DELETE FROM sessions WHERE cookie = '${cookie}'`;
        getConnection().query(query)
            .then(function(createSessionsResult) {
                resolve({});
            })
            .catch(function(error) {
                errorHandler.handleError(error);
            });
    });

    return promise;
};

var checkSessions = function(cookie) {
    var promise = new Promise(function(resolve, reject) {
        let query = 'SELECT u.username, cookie, s.expiresDate ' +
                    'FROM sessions s ' +
                    'INNER JOIN users u ON u.id = s.userId ' +
                    `WHERE cookie = "${cookie}"`;
        getConnection().query(query)
            .then(function(sessionResult) {
                resolve(sessionResult);
            })
            .catch(function(error) {
                reject(error);
            })
    });

    return promise;
};

module.exports = {
    register,
    login,
    createSession,
    deleteSession,
    deleteSessionByCookie,
    checkSessions
};

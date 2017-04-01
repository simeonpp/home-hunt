'use strict';
var config = require('../config');
var logger = require('../logger'); 

var dbConfig = config.db;
var mysql = require('promise-mysql');

let connection;

let init = new Promise(function(resolve, reject) {
  logger.log('Initing db connection...', config.logger.tags.SYSTEM);
  mysql.createConnection({
      host: dbConfig.host,
      user: dbConfig.user,
      password: dbConfig.password,
      database: dbConfig.database,
      port: dbConfig.port
  }).then(function(conn){
      connection = conn;
      logger.log('Db connection was init successfully.', config.logger.tags.SYSTEM);
      resolve();
  });
});

module.exports = {
  init: init,
  getConnection: () => { return connection }
}

const application = {
    host: '192.168.0.103',
    port: '8000',
    env: 'prod', // [dev, prod],
    apiUrl: '/api',
    publicFolder: './public',
    publicStaticFolder: './public/static/',
    publicUploadsFolder: './public/uploads/'
};

const db = {
    host: 'localhost',
    database: 'home_hunt',
    user: 'root',
    password: '123',
    port: application.env === 'dev' ? '4040' : '3306' // 3306
};

const logger = {
    type: 'console', // available types: console
    showTime: true,
    tags: {
        SYSTEM: 'system',
        INFO: 'info',
        DEBUG: 'debug',
        ERROR: 'error'
    }
}

module.exports = {
    application,
    db,
    logger
};

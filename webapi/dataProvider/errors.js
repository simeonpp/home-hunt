var dbError = function(msg) {
    return {
        type: 'PortMySQL'
    }
}

var dbErrors = [
    {
        type: 'PortMySQL.invalidResult',
        message: 'Invalid Database result'
    },
    {
        type: 'PortMySQL,error',
        message: 'PortMYSQL error'
    }
];

var dbErrorsMapped = { };
dbErrors.forEach(function(error) {
    dbErrorsMapped[error.type] = error;
})

var mapTypeToError = function(type) {
    return dbErrorsMapped[type] || dbErrorsMapped['PortMySQL,error'];
}

module.exports = {
    getError: mapTypeToError
}


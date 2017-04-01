var errors = [
    {
        type: 'Error.unknownError',
        message: 'Unknown error'
    }
];

var errorsMapped = { };
errors.forEach(function(error) {
    errorsMapped[error.type] = error;
});

var mapTypeToError = function(type) {
    return errorsMapped[type] || errorsMapped['Error.unknownError'];
};

module.exports = {
    getError: mapTypeToError
}


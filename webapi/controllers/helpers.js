var utils = require('../utils');

var mapRating = function(obj) {
    var rating = obj.rating / obj.ratingCount;
    var ratingAsFormatedString = utils.formatNumberDecimalPlace(rating, 1);
    obj.rating = parseFloat(ratingAsFormatedString);
}

module.exports = {
    mapRating
}

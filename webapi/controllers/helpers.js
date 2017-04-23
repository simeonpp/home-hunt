var utils = require('../utils');

var mapRating = function(obj) {
    var rating = 0;
    if (obj.rating > 0) {
        rating = obj.rating / obj.ratingCount;
    }
    var ratingAsFormatedString = utils.formatNumberDecimalPlace(rating, 1);
    obj.rating = parseFloat(ratingAsFormatedString);
}

var formatDate = function(date) {
    var day = date.getDate();
    var month = date.getMonth() + 1;
    var year = date.getFullYear();
    var hour = date.getHours()
    var minutes = date.getMinutes()

    Number.prototype.pad = function(size) {
      var s = String(this);
      while (s.length < (size || 2)) {s = "0" + s;}
      return s;
    }

    var result = `${day.pad()}/${month.pad()}/${year} ${hour.pad()}:${minutes.pad()}`;

    return result;
}

module.exports = {
    mapRating,
    formatDate
}

var formatNumberDecimalPlace = function(number, decimalPlace) {
    return parseFloat(Math.round(number * 100) / 100).toFixed(decimalPlace);
};

module.exports = {
    formatNumberDecimalPlace
}

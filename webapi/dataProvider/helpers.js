var formatDate = function(date) {
    var dateAsString = `${date.getFullYear()}-${('0' + (date.getMonth() + 1)).slice(-2)}-${('0' + date.getDate()).slice(-2)} `;
    dateAsString += `${('0' + date.getHours()).slice(-2)}:${('0' + date.getMinutes()).slice(-2)}:${('0' + date.getSeconds()).slice(-2)}`;

    return dateAsString; // DB format 2017-02-23 00:03:29
}

module.exports = {
    formatDate
};

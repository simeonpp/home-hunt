const log = function(msg, tag) {
    var now = new Date();
    if (tag) {
        tag = tag.toUpperCase();
        console.log(`|${dateFormatted(now)} [${tag}]|  ${msg}`);
    } else {
        console.log(`|${dateFormatted(now)}|  ${msg}`);
    }
    
}

const logHeader = function(msg, tag) {
    var now = new Date();
    console.log(Array(50).join('='));
    if (tag) {
        tag = tag.toUpperCase();
        console.log(`|${dateFormatted(now)} [${tag}]|  ${msg}`);
    } else {
        console.log(`|${dateFormatted(now)}|  ${msg}`);
    }
    console.log(Array(50).join('='));
}

var dateFormatted = function(date) {
    return date.toLocaleString("en-US");
}

module.exports = {
    log,
    logHeader
}
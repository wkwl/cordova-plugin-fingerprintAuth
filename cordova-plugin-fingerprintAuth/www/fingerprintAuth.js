var exec = require('cordova/exec');

exports.isAvailable = function (arg0, success, error) {
    exec(success, error, 'fingerprintAuth', 'isAvailable', [arg0]);
};

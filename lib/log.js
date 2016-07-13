'use strict';

var bunyan = require('bunyan');

var config = require('../config/config');

var log = bunyan.createLogger({
	name: 'Dummy Server',
	level: 'debug'
});

module.exports = {
	http: log,
	fatal: log.fatal.bind(log),
	error: log.error.bind(log),
	warn: log.warn.bind(log),
	info: log.info.bind(log),
	debug: log.debug.bind(log),
	trace: log.trace.bind(log)
};

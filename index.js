'use strict';

var server = require('./lib/server');

var config = require('./config/config');
var api = require('./lib/api');

server.configure(api);
server.start(config.web.port, config.web.host);

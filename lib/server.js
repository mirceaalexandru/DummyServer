'use strict';

var restify = require('restify');

var log = require('./log');

var server = restify.createServer({
	name: 'Dummy Server'
});

function configure(api) {
	api.register(server, routeTo);
}

function startServer(port, hostname) {
	server.listen(port, hostname);
}

function closeServer(cb) {
	server.close(cb);
}

function routeTo(action) {
	return function route(req, res, next) {
		var data = {
			headers: req.headers,
			params: req.params,
			body: req.body || {}
		};

		action(data, function actionResponse(err, result) {
			if (err) {
				log.error(err);
				res.send(err.statusCode || 500, {
					code: err.code,
					message: err.message
				});
				return next();
			}

			res.json(result);
			next();
		});
	};
}

server.on('after', restify.auditLogger({
	log: log.http
}));

server.use(restify.bodyParser({mapParams: false}));

module.exports = {
	start: startServer,
	close: closeServer,
	configure: configure,
	routeTo: routeTo
};

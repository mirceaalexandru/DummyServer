'use strict';

function pong(data, done){
	done(null, {pong: new Date()})
}

function register(server, routeTo) {
	server.get('/ping', routeTo(pong));
}

module.exports = {
	register: register
};

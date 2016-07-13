'use strict';

try {
	require('dotenv').config({silent: true});
} catch (err) {}

module.exports = {
	web: {
		port: process.env.WEB_PORT || 3000,
		host: process.env.WEB_HOST
	},
	AWS: {
		accessKeyId: process.env.AWS_ACCESS_KEY_ID,
		secretAccessKey: process.env.AWS_SECRET_ACCESS_KEY,
		region: process.env.AWS_REGION
	}
};

/**
 * @module config
 * @description
 * Loads environment variables from a .env file 
 * usage:
 *  const env = require('./config/config.js');
 *  console.log(env.port); 
 */
const path = require('path');
require('dotenv').config({ path: path.resolve(__dirname, '.env') });

//exporting environment variables
module.exports = {
    port: process.env.PORT,
    node_env: process.env.NODE_ENV,
};  
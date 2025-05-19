/**
 * @module index
 * @description
 * Basic root API endpoint for testing server.
 */
const router = require('express').Router();
/**
 * @route GET /
 * @description Returns a basic message for testing server.
 */
router.get('/', (req, res) => {
    // Send a 200 OK response with a JSON message.
    res.status(200).json({ message: 'Hello from the backend' });
});
// Export the router to be used in main app
module.exports = router;
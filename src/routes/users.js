const express = require('express');
const router = express.Router();
const userController = require('../controllers/userController');

router.get('/', userController.getAllUsers);
router.get('/current/user', userController.getCurrentUser)
router.get('/:id', userController.getUserById);
router.post('/register', userController.register);
router.post('/login', userController.login);

module.exports = router;

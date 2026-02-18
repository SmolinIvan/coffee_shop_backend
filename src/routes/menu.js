const express = require('express');
const router = express.Router();
const menuController = require('../controllers/menuController');
const { verifyToken, verifyAdmin, verifyManager } = require('../middleware/auth');

// Категории
router.get('/categories', menuController.getCategories);

// CRUD для блюд
router.get('/', menuController.getAllItems);
router.get('/:id', menuController.getItemById);

router.post('/', verifyToken, verifyManager, menuController.createItem);
router.put('/:id', verifyToken, verifyManager, menuController.updateItem);
router.delete('/:id', verifyToken, verifyAdmin, menuController.deleteItem);

module.exports = router;

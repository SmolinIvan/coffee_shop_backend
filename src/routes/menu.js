const express = require('express');
const router = express.Router();
const menuController = require('../controllers/menuController');

// Категории
router.get('/categories', menuController.getCategories);

// CRUD для блюд
router.get('/', menuController.getAllItems);
router.get('/:id', menuController.getItemById);
router.post('/', menuController.createItem);
router.put('/:id', menuController.updateItem);
router.delete('/:id', menuController.deleteItem);

module.exports = router;

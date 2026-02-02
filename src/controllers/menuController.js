const db = require('../config/database');

// Получить все блюда
exports.getAllItems = async (req, res) => {
  try {
    const { category, type, available } = req.query;
    
    let query = `
      SELECT 
        m.id,
        m.name,
        m.description,
        m.price,
        m.image_url as "imageRef",
        c.type,
        jsonb_build_object(
          'kcal', m.kcal,
          'protein', m.protein,
          'fat', m.fat,
          'carbs', m.carbs
        ) as energy,
        m.available,
        m.created_at
      FROM menu_items m
      LEFT JOIN categories c ON m.category_id = c.id
      WHERE 1=1
    `;
    const params = [];
    
    if (category) {
      params.push(category);
      query += ` AND c.name = $${params.length}`;
    }
    
    if (type) {
      params.push(type);
      query += ` AND c.type = $${params.length}`;
    }
    
    if (available !== undefined) {
      params.push(available === 'true');
      query += ` AND m.available = $${params.length}`;
    }
    
    query += ' ORDER BY m.id';
    
    const result = await db.query(query, params);
    res.json(result.rows);
  } catch (error) {
    console.error('Error fetching menu items:', error);
    res.status(500).json({ error: 'Failed to fetch menu items' });
  }
};

// Получить блюдо по ID
exports.getItemById = async (req, res) => {
  try {
    const { id } = req.params;
    const result = await db.query(
      `SELECT 
        m.id,
        m.name,
        m.description,
        m.price,
        m.image_url as "imageRef",
        c.type,
        jsonb_build_object(
          'kcal', m.kcal,
          'protein', m.protein,
          'fat', m.fat,
          'carbs', m.carbs
        ) as energy,
        m.available
      FROM menu_items m
      LEFT JOIN categories c ON m.category_id = c.id
      WHERE m.id = $1`,
      [id]
    );
    
    if (result.rows.length === 0) {
      return res.status(404).json({ error: 'Item not found' });
    }
    
    res.json(result.rows[0]);
  } catch (error) {
    console.error('Error fetching item:', error);
    res.status(500).json({ error: 'Failed to fetch item' });
  }
};

// Создать новое блюдо
exports.createItem = async (req, res) => {
  try {
    const { name, description, price, imageRef, type, energy, available } = req.body;
    
    if (!name || !price || !type) {
      return res.status(400).json({ error: 'Name, price and type are required' });
    }
    
    // Получаем category_id по type
    const categoryResult = await db.query(
      'SELECT id FROM categories WHERE type = $1',
      [type]
    );
    
    if (categoryResult.rows.length === 0) {
      return res.status(400).json({ error: 'Invalid category type' });
    }
    
    const category_id = categoryResult.rows[0].id;
    
    const result = await db.query(
      `INSERT INTO menu_items 
        (name, description, price, image_url, category_id, kcal, protein, fat, carbs, available)
       VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10)
       RETURNING *`,
      [
        name, 
        description, 
        price, 
        imageRef, 
        category_id,
        energy?.kcal,
        energy?.protein,
        energy?.fat,
        energy?.carbs,
        available !== false
      ]
    );
    
    res.status(201).json(result.rows[0]);
  } catch (error) {
    console.error('Error creating item:', error);
    res.status(500).json({ error: 'Failed to create item' });
  }
};

// Обновить блюдо
exports.updateItem = async (req, res) => {
  try {
    const { id } = req.params;
    const { name, description, price, imageRef, type, energy, available } = req.body;
    
    let category_id;
    if (type) {
      const categoryResult = await db.query(
        'SELECT id FROM categories WHERE type = $1',
        [type]
      );
      category_id = categoryResult.rows[0]?.id;
    }
    
    const result = await db.query(
      `UPDATE menu_items 
       SET 
         name = COALESCE($1, name),
         description = COALESCE($2, description),
         price = COALESCE($3, price),
         image_url = COALESCE($4, image_url),
         category_id = COALESCE($5, category_id),
         kcal = COALESCE($6, kcal),
         protein = COALESCE($7, protein),
         fat = COALESCE($8, fat),
         carbs = COALESCE($9, carbs),
         available = COALESCE($10, available),
         updated_at = CURRENT_TIMESTAMP
       WHERE id = $11
       RETURNING *`,
      [
        name, 
        description, 
        price, 
        imageRef, 
        category_id,
        energy?.kcal,
        energy?.protein,
        energy?.fat,
        energy?.carbs,
        available,
        id
      ]
    );
    
    if (result.rows.length === 0) {
      return res.status(404).json({ error: 'Item not found' });
    }
    
    res.json(result.rows[0]);
  } catch (error) {
    console.error('Error updating item:', error);
    res.status(500).json({ error: 'Failed to update item' });
  }
};

// Удалить блюдо
exports.deleteItem = async (req, res) => {
  try {
    const { id } = req.params;
    
    const result = await db.query(
      'DELETE FROM menu_items WHERE id = $1 RETURNING *',
      [id]
    );
    
    if (result.rows.length === 0) {
      return res.status(404).json({ error: 'Item not found' });
    }
    
    res.json({ 
      message: 'Item deleted successfully', 
      item: result.rows[0] 
    });
  } catch (error) {
    console.error('Error deleting item:', error);
    res.status(500).json({ error: 'Failed to delete item' });
  }
};

// Получить категории
exports.getCategories = async (req, res) => {
  try {
    const result = await db.query('SELECT * FROM categories ORDER BY id');
    res.json(result.rows);
  } catch (error) {
    console.error('Error fetching categories:', error);
    res.status(500).json({ error: 'Failed to fetch categories' });
  }
};

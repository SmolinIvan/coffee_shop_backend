-- Migration: Initial schema
-- Created: 2024-01-15
-- Description: Create tables for coffee shop

-- Таблица категорий
CREATE TABLE IF NOT EXISTS categories (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL UNIQUE,
    type VARCHAR(50) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Таблица пользователей
CREATE TABLE IF NOT EXISTS users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    role VARCHAR(20) DEFAULT 'user',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Таблица блюд/напитков
CREATE TABLE IF NOT EXISTS menu_items (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    price DECIMAL(10, 2) NOT NULL,
    image_url VARCHAR(500),
    category_id INTEGER REFERENCES categories(id) ON DELETE SET NULL,
    available BOOLEAN DEFAULT true,
    
    -- Энергетическая ценность
    kcal INTEGER,
    protein DECIMAL(5, 1),
    fat DECIMAL(5, 1),
    carbs DECIMAL(5, 1),
    
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Индексы для оптимизации
CREATE INDEX idx_menu_items_category ON menu_items(category_id);
CREATE INDEX idx_menu_items_available ON menu_items(available);
CREATE INDEX idx_users_email ON users(email);
CREATE INDEX idx_categories_type ON categories(type);

-- Вставка категорий
INSERT INTO categories (name, type) VALUES 
    ('Напитки', 'drinks'),
    ('Закуски', 'appetizers'),
    ('Салаты', 'salads'),
    ('Горячее', 'hot'),
    ('Выпечка', 'bakery'),
    ('Десерты', 'desserts'),
    ('Бар', 'bar')
ON CONFLICT (name) DO NOTHING;

-- Тестовый админ (пароль: admin123)
INSERT INTO users (username, email, password_hash, role) VALUES 
    ('admin', 'admin@coffee-shop.local', '$2b$10$rT4YzKvQxKjKx3qP8Zw8xuXqYqZ8hF6vQ3wM5xN7yK8pL2qR9sT6m', 'admin')
ON CONFLICT (email) DO NOTHING;

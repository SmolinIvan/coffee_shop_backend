const { Pool } = require('pg');
require('dotenv').config({ path: '.env.local' });

const isProduction = process.env.NODE_ENV === 'production';

const pool = new Pool({
  host: process.env.DB_HOST,
  port: process.env.DB_PORT,
  database: process.env.DB_NAME,
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
});

// Цветной лог
const envColor = isProduction ? '\x1b[31m' : '\x1b[32m'; // Красный/Зеленый
const reset = '\x1b[0m';

pool.on('connect', () => {
  console.log(`${envColor}✅ Database connected: ${process.env.DB_NAME} (${process.env.NODE_ENV})${reset}`);
});

pool.on('error', (err) => {
  console.error('❌ Unexpected database error:', err);
  process.exit(-1);
});

module.exports = pool;

const fs = require('fs');
const path = require('path');
const { Pool } = require('pg');
require('dotenv').config({ path: '.env.local' });

const pool = new Pool({
  host: process.env.DB_HOST,
  port: process.env.DB_PORT,
  database: process.env.DB_NAME,
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
});

async function runMigrations() {
  const client = await pool.connect();
  
  try {
    console.log('🔄 Starting migrations...\n');
    console.log(`📊 Database: ${process.env.DB_NAME}`);
    console.log(`👤 User: ${process.env.DB_USER}`);
    console.log(`🌍 Environment: ${process.env.NODE_ENV}\n`);

    // Создаем таблицу миграций
    const createMigrationsTable = fs.readFileSync(
      path.join(__dirname, '000_create_migrations_table.sql'),
      'utf8'
    );
    await client.query(createMigrationsTable);

    // Получаем примененные миграции
    const appliedResult = await client.query('SELECT name FROM migrations ORDER BY id');
    const appliedMigrations = appliedResult.rows.map(row => row.name);

    // Получаем все файлы миграций
    const migrationFiles = fs.readdirSync(__dirname)
      .filter(file => file.endsWith('.sql') && file !== '000_create_migrations_table.sql')
      .sort();

    let appliedCount = 0;

    for (const file of migrationFiles) {
      const migrationName = file.replace('.sql', '');

      if (appliedMigrations.includes(migrationName)) {
        console.log(`⏭️  ${migrationName} (already applied)`);
        continue;
      }

      console.log(`▶️  Applying ${migrationName}...`);

      const migrationSQL = fs.readFileSync(path.join(__dirname, file), 'utf8');

      await client.query('BEGIN');
      try {
        await client.query(migrationSQL);
        await client.query('INSERT INTO migrations (name) VALUES ($1)', [migrationName]);
        await client.query('COMMIT');
        console.log(`✅ Applied ${migrationName}\n`);
        appliedCount++;
      } catch (error) {
        await client.query('ROLLBACK');
        console.error(`❌ Error applying ${migrationName}:`, error.message);
        throw error;
      }
    }

    if (appliedCount === 0) {
      console.log('✨ Database is up to date!\n');
    } else {
      console.log(`🎉 Successfully applied ${appliedCount} migration(s)!\n`);
    }

  } catch (error) {
    console.error('❌ Migration failed:', error);
    process.exit(1);
  } finally {
    client.release();
    await pool.end();
  }
}

runMigrations();

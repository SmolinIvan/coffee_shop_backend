const fs = require('fs');
const path = require('path');

const migrationName = process.argv[2];

if (!migrationName) {
  console.error('❌ Please provide migration name');
  console.log('Usage: npm run migrate:create <migration_name>');
  console.log('Example: npm run migrate:create add_orders_table');
  process.exit(1);
}

const migrations = fs.readdirSync(__dirname)
  .filter(file => file.endsWith('.sql') && file !== '000_create_migrations_table.sql')
  .sort();

const nextNumber = migrations.length + 1;
const paddedNumber = String(nextNumber).padStart(3, '0');
const fileName = `${paddedNumber}_${migrationName}.sql`;
const filePath = path.join(__dirname, fileName);

const template = `-- Migration: ${migrationName.replace(/_/g, ' ')}
-- Created: ${new Date().toISOString().split('T')[0]}
-- Description: 

-- Your SQL code here

`;

fs.writeFileSync(filePath, template);
console.log(`✅ Created migration: ${fileName}`);
console.log(`📝 Edit the file and run: npm run migrate`);

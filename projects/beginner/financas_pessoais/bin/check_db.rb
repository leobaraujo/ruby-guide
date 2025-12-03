#!/usr/bin/env ruby

require "sqlite3"

puts "=== Verificando Bando de Dados ==="
db_file = "data/database.db"
db = File.exists?(db_file) ? SQLite3::Database.open(db_file) : SQLite3::Database.new(db_file)

# Tabela users
users_table = db.execute <<~SQL
  SELECT name 
  FROM sqlite_master 
  WHERE type='table' AND name='fp_users';
SQL

if users_table.empty?
  puts "Criando tabela <fp_users>"
  db.execute <<~SQL
    CREATE TABLE fp_users (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT NOT NULL
    );
  SQL
end

# Tabela categories
categories_table = db.execute <<~SQL
  SELECT name 
  FROM sqlite_master 
  WHERE type='table' AND name='fp_categories';
SQL

if categories_table.empty?
  puts "Criando tabela <fp_categories>"
  db.execute <<~SQL
    CREATE TABLE fp_categories (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT NOT NULL
    );
  SQL
end

# Tabela transações
transactions_table = db.execute <<~SQL
  SELECT name 
  FROM sqlite_master 
  WHERE type='table' AND name='fp_transactions';
SQL

if transactions_table.empty?
  puts "Criando tabela <fp_transactions>"
  db.execute <<~SQL
    CREATE TABLE fp_transactions (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      fp_users_id INTEGER NOT NULL,
      fp_categories_id INTEGER NOT NULL,
      value REAL NOT NULL,
      date TEXT NOT NULL,
      FOREIGN KEY (fp_users_id) REFERENCES fp_users(id),
      FOREIGN KEY (fp_categories_id) REFERENCES fp_categories(id)
    );
  SQL
end

db.close

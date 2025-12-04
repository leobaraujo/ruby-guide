#!/usr/bin/env ruby

require "sqlite3"

db_file = "data/database.db"

return unless File.exists? db_file

db = SQLite3::Database.open db_file

puts "=== Removendo tabelas ==="
puts "Removendo tabela <fp_users>"
db.execute("DROP TABLE IF EXISTS fp_users;")
puts "Removendo tabela <fp_categories>"
db.execute("DROP TABLE IF EXISTS fp_categories;")
puts "Removendo tabela <fp_transactions>"
db.execute("DROP TABLE IF EXISTS fp_transactions;")

db.close

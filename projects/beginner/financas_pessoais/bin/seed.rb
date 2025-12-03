#!/usr/bin/env ruby

require "sqlite3"

system "bin/reset_db.rb"
system "bin/check_db.rb"

puts "=== Começando seed ==="
db_file = "data/database.db"

return unless File.exists? db_file

db = SQLite3::Database.open db_file

puts "Semeando <fp_users>"
[
  ["Lucas Almeida"],
  ["Fernanda Ribeiro"],
  ["Gabriel Souza"],
  ["Mariana Castro"],
  ["Bruno Fernandes"]
].each do |user|
  db.execute("INSERT INTO fp_users (name) VALUES (?)", user)
end

puts "Semeando <fp_categories>"
[
  ["Alimentação"],
  ["Moradia"],
  ["Transporte"],
  ["Lazer"],
  ["Saúde"]
].each do |category|
  db.execute("INSERT INTO fp_categories (name) VALUES (?)", category)
end

puts "Semeando <fp_transactions>"
[
  [1, 1, 150.75, '2025-06-01 08:30:15'],
  [2, 3, 60.00,  '2025-06-02 14:45:00'],
  [3, 5, 120.40, '2025-06-03 19:20:05'],
  [4, 2, 800.00, '2025-06-01 07:10:30'],
  [5, 4, 200.50, '2025-06-04 12:00:00'],
  [1, 2, 450.00, '2025-06-05 16:25:45'],
  [2, 5, 90.25,  '2025-06-06 09:15:20'],
  [3, 1, 100.00, '2025-06-07 21:05:10'],
  [4, 3, 75.00,  '2025-06-08 11:30:55'],
  [5, 4, 300.00, '2025-06-09 18:40:00']
].each do |transaction|
  db.execute("INSERT INTO fp_transactions (fp_users_id, fp_categories_id, value, date) VALUES (?, ?, ?, ?)", transaction)
end

db.close

#!/usr/bin/env ruby

require_relative "../lib/financas_pessoais"

system "bin/check_db.rb"

puts "=== Iniciando App ==="
FinancasPessoais.start

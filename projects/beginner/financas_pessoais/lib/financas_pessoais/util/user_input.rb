require "singleton"

module FinancasPessoais
  module Util
    def self.get_option(range)
      loop do
        print "\n> Opção: "
        input = gets.chomp[0].to_i

        if range.include? input then return input
        else puts "Insira uma opção válida."
        end
      end
    end
  end
end

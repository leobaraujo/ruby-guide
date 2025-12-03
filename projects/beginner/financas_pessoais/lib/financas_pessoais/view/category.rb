require "terminal-table"
require_relative "../controller/category.rb"

module FinancasPessoais
  module View
    module Category
      def self.menu
        puts
        puts <<~TEXT
          Escolha uma opção:
          1. Listar todos
          2. Buscar
          3. Nova categoria
          4. Atualizar categoria
          5. Remover categoria
          6. Voltar
        TEXT

        input = Util.get_option (1..6)

        case input
        when 1 then list_all
        when 2 then search_by_id
        when 3 then create
        when 4 then update
        when 5 then delete
        when 6 then FinancasPessoais.start
        end
      end

      private
        def self.list_all
          puts `clear`
          category = Controller::Category.index
          rows = [["Id", "Nome"]]
          rows << :separator
          rows += category unless category.nil? or category.empty?

          puts "#{Terminal::Table.new rows: rows}"

          menu
        end

        def self.search_by_id
          puts `clear`
          print "> Digite o <id> da categoria: "
          input = gets.chomp.to_i

          category = Controller::Category.show input

          rows = [["Id", "Nome"]]
          rows << :separator
          rows << category

          puts "#{Terminal::Table.new :rows => rows}" unless category.nil?

          menu
        end

        def self.create
          puts `clear`
          puts "Para registrar uma nova categoria, informe os dados a seguir."
          print "> Nome: "
          name = gets.chomp

          if Controller::Category.create name
            puts "Categoria registrada com sucesso!"
          end

          menu
        end

        def self.update
          puts `clear`
          puts "Para atualizar uma categoria, informe os dados a seguir."
          print "> Id: "
          id = gets.chomp.to_i
          print "> Nome: "
          name = gets.chomp

          if Controller::Category.update id, name
            puts "Categoria atualizada com sucesso!"
          end

          menu
        end

        def self.delete
          puts `clear`
          puts "Para remover uma categoria, informe os dados a seguir."
          print "> Id: "
          id = gets.chomp.to_i

          if Controller::Category.destroy id
            puts "Categoria removida com sucesso!"
          end

          menu
        end
    end
  end
end

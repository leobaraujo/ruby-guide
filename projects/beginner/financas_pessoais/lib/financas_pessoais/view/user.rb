require "terminal-table"
require_relative "../controller/user.rb"

module FinancasPessoais
  module View
    module User
      def self.menu
        puts
        puts <<~TEXT
          Escolha uma opção:
          1. Listar todos
          2. Buscar
          3. Novo cadastro
          4. Atualizar cadastro
          5. Remover cadastro
          6. Transações
          7. Voltar
        TEXT

        input = Util.get_option (1..7)

        case input
        when 1 then list_all
        when 2 then search_by_id
        when 3 then create
        when 4 then update
        when 5 then delete
        when 6 then transaction
        when 7 then FinancasPessoais.start
        end
      end

      private
        def self.list_all
          puts `clear`
          users = Controller::User.index
          rows = [["Id", "Nome"]]
          rows << :separator
          rows += users unless users.nil? or users.empty?

          puts "#{Terminal::Table.new rows: rows}"

          menu
        end

        def self.search_by_id
          puts `clear`
          print "> Digite o <id> do usuário: "
          input = gets.chomp.to_i

          user = Controller::User.show input

          rows = [["Id", "Nome"]]
          rows << :separator
          rows << user

          puts "#{Terminal::Table.new :rows => rows}" unless user.nil?

          menu
        end

        def self.create
          puts `clear`
          puts "Para registrar um novo usuário, informe os dados a seguir."
          print "> Nome: "
          name = gets.chomp

          if Controller::User.create name
            puts "Usuário registrado com sucesso!"
          end

          menu
        end

        def self.update
          puts `clear`
          puts "Para atualizar um usuário, informe os dados a seguir."
          print "> Id: "
          id = gets.chomp.to_i
          print "> Nome: "
          name = gets.chomp

          if Controller::User.update id, name
            puts "Usuário atualizado com sucesso!"
          end

          menu
        end

        def self.delete
          puts `clear`
          puts "Para remover um usuário, informe os dados a seguir."
          print "> Id: "
          id = gets.chomp.to_i

          if Controller::User.destroy id
            puts "Usuário removido com sucesso!"
          end

          menu
        end

        def self.transaction
          puts `clear`
          print "> Antes de continuar, informe o <id> do usuário: "
          input = gets.chomp.to_i

          user = Controller::User.login input

          if user.nil?
            puts "Usuário não encontrado."
            return menu
          end

          transaction_options user
        end

        def self.transaction_options(user)
          puts `clear`
          puts <<~TEXT
            Usuário: #{user.name}
            Saldo: R$ #{user.balance}
            Informe qual ação deseja realizar:
            1. Depósito
            2. Saque
            3. Voltar
          TEXT

          input = Util.get_option (1..3)

          case input
          when 1 then deposit user
          when 2 then withdraw user
          when 3 then
            puts `clear`
            menu
          end
        end

        def self.deposit(user)
          puts `clear`
          print "> Informe o valor para depósito, utilizando ponto (.) no lugar da vírgula (,): "
          deposit_value = gets.chomp.to_f

          print "> Informe o <id> da categoria de depósito: "
          category_id = gets.chomp.to_i

          Controller::User.deposit user, category_id, deposit_value
          transaction_options user
        end

        def self.withdraw(user)
          puts `clear`
          print "> Informe o valor para saque, utilizando ponto (.) no lugar da vírgula (,): "
          deposit_value = gets.chomp.to_f

          Controller::User.withdraw user, deposit_value
          transaction_options user
        end
    end
  end
end

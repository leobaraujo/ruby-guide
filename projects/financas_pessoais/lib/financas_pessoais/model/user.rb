require_relative "transaction.rb"

module FinancasPessoais
  module Model
    class User
      attr_reader :id
      attr_accessor :name

      def initialize((id, name))
        @id = id
        @name = name
        @transactions ||= Transaction.find_by_user_id id
      end

      def self.all
        $DB.execute "SELECT * FROM fp_users"
      end

      def self.find(id)
        $DB.execute "SELECT * FROM fp_users WHERE id = ?", id
      end

      def save
        return false unless validate

        $DB.execute "INSERT INTO fp_users (name) VALUES (?)", [ @name ]
        return true
      end

      def update
        return false unless validate
        return false unless verify_user

        $DB.execute "UPDATE fp_users SET name = ? WHERE id = ?", [ @name, @id ]
        return true
      end

      def destroy
        return false unless verify_user

        $DB.execute "DELETE FROM fp_users WHERE id = ?", [ @id ]
        return true
      end

      def balance
        return 0.0 if @transactions.empty?
        @transactions.reduce(0.0) { |acc, transaction| acc + transaction.value }
      end

      def deposit(category_id, value)
        return unless validate_transaction value
        
        transaction = Transaction.new([nil, id, category_id, value, Time.now])
        transaction.save

        @transactions << transaction
        return true
      end
      
      def withdraw(value)
        return unless validate_transaction value

        new_balance = balance - value

        if new_balance < 0
          puts "Saldo insuficiente."
          return false
        end

        transaction = Transaction.new([nil, id, -1, value * -1, Time.now])
        transaction.save

        @transactions << transaction
        return true
      end

      private
        def validate
          if @name.empty? or @name.nil?
            puts "O <nome> não pode estar em branco."
            return false
          end

          return true
        end

        def verify_user
          if User.find(@id).empty?
            puts "Usuário não encontrado."
            return false
          end

            return true
        end

        def validate_transaction(value)
          unless value.is_a?(Integer) || value.is_a?(Float)
            puts "Insira um valor válido."
            return false
          end

          if value <= 0
            puts "Transações com valores negativos ou iguais a zero (0) não são permitidas."
            return false
          end

          return true
        end
    end
  end
end

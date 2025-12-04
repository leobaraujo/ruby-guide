module FinancasPessoais
  module Model
    class Transaction
      attr_reader :value

      def initialize((id, fp_users_id, fp_categories_id, value, date))
        @id = id
        @fp_users_id = fp_users_id
        @fp_categories_id = fp_categories_id
        @value = value
        @date = date.to_s
      end

      def self.all
        $DB.execute "SELECT * FROM fp_transactions"
      end

      def self.find(id)
        $DB.execute "SELECT * FROM fp_transactions WHERE id = ?", id
      end

      def self.find_by_user_id(id)
        transactions = $DB.execute("SELECT * FROM fp_transactions WHERE fp_users_id = ?", id) || []
        transactions.map { |transaction| self.new transaction.values }
      end

      def save
        $DB.execute "INSERT INTO fp_transactions (fp_users_id, fp_categories_id, value, date) VALUES (?, ?, ?, ?)", [ @fp_users_id, @fp_categories_id, @value, @date ]
        return true
      end
    end
  end
end

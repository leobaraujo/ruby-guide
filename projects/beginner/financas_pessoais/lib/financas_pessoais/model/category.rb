module FinancasPessoais
  module Model
    class Category
      attr_accessor :name

      def initialize(id, name)
        @id = id
        @name = name
      end

      def self.all
        $DB.execute "SELECT * FROM fp_categories"
      end

      def self.find(id)
        $DB.execute "SELECT * FROM fp_categories WHERE id = ?", id
      end

      def save
        return false unless validate

        $DB.execute "INSERT INTO fp_categories (name) VALUES (?)", [ @name ]
        return true
      end

      def update
        return false unless validate
        return false unless verify_category

        $DB.execute "UPDATE fp_categories SET name = ? WHERE id = ?", [ @name, @id ]
        return true
      end

      def destroy
        return false unless verify_category

        $DB.execute "DELETE FROM fp_categories WHERE id = ?", [ @id ]
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

        def verify_category
          if Category.find(@id).empty?
            puts "Categoria não encontrada."
            return false
          end

            return true
        end
    end
  end
end

require "sqlite3"
require_relative "../model/user.rb"

module FinancasPessoais
  module Controller
    module User
      def self.index
        Model::User.all.map { |user| [ user["id"], user["name"] ] }
      end

      def self.show(id)
        user = Model::User.find id
        return [] if user.empty?
        user[0].values
      end

      def self.create(name)
        user = Model::User.new nil, name
        user.save
      end

      def self.update(id, name)
        user = Model::User.new id, name
        user.update
      end

      def self.destroy(id)
        user = Model::User.new id, nil
        user.destroy
      end

      def self.login(id)
        user = self.show id
        return nil if user.empty?
        Model::User.new user
      end

      def self.deposit(user, category_id, deposit_value)
        category = Category.show category_id

        if category.empty?
          puts "Insira uma categoria válida."
          return false
        end

        user.deposit category_id, deposit_value
      end

      def self.withdraw(user, deposit_value)
        user.withdraw deposit_value
      end
    end
  end
end

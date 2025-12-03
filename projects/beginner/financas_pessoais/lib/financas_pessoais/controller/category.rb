require "sqlite3"
require_relative "../model/category.rb"

module FinancasPessoais
  module Controller
    module Category
      def self.index
        Model::Category.all.map { |category| [ category["id"], category["name"] ] }
      end

      def self.show(id)
        category = Model::Category.find id
        return [] if category.empty?
        category[0].values
      end

      def self.create(name)
        category = Model::Category.new nil, name
        category.save
      end

      def self.update(id, name)
        category = Model::Category.new id, name
        category.update
      end

      def self.destroy(id)
        category = Model::Category.new id, nil
        category.destroy
      end
    end
  end
end

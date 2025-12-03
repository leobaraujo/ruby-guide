require_relative "financas_pessoais/view/user.rb"
require_relative "financas_pessoais/view/category.rb"
require_relative "financas_pessoais/util/user_input.rb"

$DB = SQLite3::Database.open "data/database.db"
$DB.results_as_hash = true

module FinancasPessoais
  def self.start
    main_menu
  end

  private
    def self.main_menu
      print `clear`
      puts "Qual área você deseja acessar?
      1. Usuários
      2. Categorias
      3. Sair".gsub(/^\s+/, '')

      input = Util.get_option (1..3)

      case input
      when 1 then View::User.menu
      when 2 then View::Category.menu
      when 3 then exit 1
      end
    end
end

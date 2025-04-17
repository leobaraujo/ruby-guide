# Decidim

> Em desenvolvimento. Sujeito a alterações

## Criando content_block (cell)

```ruby
# config/initializers/custom_content_blocks.rb
# manifests-registry pattern ('custom_content_blocks' pode ser outro nome)
# :homepage = escopo / :meu_bloco = nome da cell
# "content_blocks" presente no path é o nome do seu módulo personalizado
Decidim.content_blocks.register(:homepage, :meu_bloco) do |content_block|
  content_block.cell = "decidim/content_blocks/meu_bloco"
  content_block.public_name_key = "decidim.content_blocks.meu_bloco.name" # I18n lang locale path '*.yml'

  # (Opcional todos as linhas a partir desta) Cria um formulário de edição de cell no painel administrativo
  content_block.settings_form_cell = "decidim/content_blocks/meu_bloco_settings_form"

  # Define o campo "meu_bloco" como um "atributo" do bloco (o nome não precisa ser igual ao da célula)
  content_block.settings do |settings|
    settings.attribute :meu_bloco, type: :text

    # (Opcional) Adicione o argumento 'translated: true' para que o atributo tenha vários campos de idiomas. Gera um hash de idiomas. Ex.: {"pt-BR" => "TEXTO_AQUI"}
    # settings.attribute :meu_bloco, type: :text, translated: true
  end
end

# config/locales/pt-BR.yml
"pt-BR":
  decidim:
    content_blocks:
      meu_bloco:
        name: "Meu Bloco"
        settings_form: # (Opcional) Apenas se tiver conteúdo definido pelo ADM
          label: "Conteúdo" # Texto do atributo que será modificado pelo ADM.

# (Opcional) Apenas se tiver conteúdo definido pelo ADM
# app/cells/decidim/content_blocks/meu_bloco_settings_form_cell.rb
module Decidim
  module ContentBlocks
    class MeuBlocoSettingsFormCell < Decidim::ViewModel
      alias form model # 'model' será o objeto acessado dentro do template *.erb

      def content_block
        options[:content_block]
      end

      # Método que busca o texto do campo 'label', pode ser outro nome
      def label
        I18n.t("decidim.content_blocks.meu_bloco.settings_form.label")
      end
    end
  end
end

# (Opcional) Apenas se tiver conteúdo definido pelo ADM
# app/cells/decidim/content_blocks/meu_bloco_settings_form_cell/show.erb
<% form.fields_for :settings, form.object.settings do |settings_fields| %>
  <%= settings_fields.text_area :meu_bloco, label: label %>
  # (Opcional) Adicione o argumento 'translated' para que o atributo seja traduzido pelo 'locale'
  # <%= settings_fields.translated :text_area, :meu_bloco, label: label %>
<% end %>

# app/cells/decidim/content_blocks/meu_bloco_cell.rb
module Decidim
  module ContentBlocks
    class MeuBlocoCell < Decidim::ViewModel
      def nome_do_metodo
        "Hello, world!"
      end

      def show
        render
      end
    end
  end
end

# app/cells/decidim/content_blocks/meu_bloco/show.erb
<section id="meu_bloco">
  <h2><%= nome_do_metodo %></h2> # Chama o método 'nome_do_metodo'
  <p>Hello, world</p> # Texto estático
  <p><%= model.settings.meu_bloco %></p> # Texto dinâmico, definido no painel administrativo
</section>
```

## Configuração SMTP

> Envio de emails através do **console** busca a configuração de script ruby. Envio de emails através da plataforma busca a configuração definida na \<url>/system da organização

```ruby
# app/config/environments/[development | production].rb

# ENV.fetch("KEY") busca pelas variáveis de ambiente
# NÃO utilize 'Rails.application.secrets.*' (Verificar config/secrets.yml)
config.action_mailer.delivery_method = :smtp
config.action_mailer.smtp_settings = {
  address:              ENV.fetch("SMTP_ADDRESS"),
  port:                 ENV.fetch("SMTP_PORT").to_i,
  domain:               ENV.fetch("SMTP_DOMAIN"),
  user_name:            ENV.fetch("SMTP_USERNAME"),
  password:             ENV.fetch("SMTP_PASSWORD"),
  authentication:       :login,
  enable_starttls_auto: true
}
```

```yml
# app/config/application.yml (gem Figaro)

SMTP_ADDRESS: "smtp.gmail.com"
SMTP_PORT: "587"
SMTP_DOMAIN: "localhost"
SMTP_USERNAME: "email@example.org"
SMTP_PASSWORD: "senha_monstro"
```

### Gemas necessárias

> OBS: **delayed_job** deve estar em execução junto do servidor. É um processo paralelo que deve ser iniciado **manualmente**.

- gem "passenger"
- gem "delayed_job_active_record"
- gem "daemons"

```shell
# Instalação (Após ter adicionado no Gemfile)

bundle install
bin/rails generate delayed_job:active_record
bin/rake db:migrate
```

```shell
# Execução delayed_job

# Desenvolvimento
bin/delayed_job restart
bin/delayed_job status

# Produção
RAILS_ENV=production bin/delayed_job stop
RAILS_ENV=production bin/delayed_job start
```

```shell
# Envio de email através do prompt 'rails console'

ActionMailer::Base.mail(
  from: ENV.fetch('SMTP_USERNAME'),
  to: 'email@example.org',
  subject: 'Teste de e-mail',
  body: 'Este é um e-mail de teste.'
).deliver_now
```

# Ruby

## História

Foi publicada em 1995 por Yukihiro "Matz" Matsumoto no Japão. Ela combina ideias de várias linguagens como Perl, Smalltalk, Eiffel, Ada e Lisp, e é conhecida por sua sintaxe legível e elegante.

Características:

- Interpretada
- Alto nível
- Tipagem dinâmica
- Orientada a objetos (Tudo é objeto, inclusive números)
- Multithreading
- Sistema robusto de tratamento de exceções, semelhante ao Java
- Extensão do arquivo: \*.rb

Sintaxe:

> TODO

Instalação:

- [rvm](https://rvm.io/rvm/install) ou [rbenv](https://github.com/rbenv/rbenv): São gerenciadores de versões Ruby

Executando script ruby:

```shell
ruby meu_script.rb
```

## REPL: IRB e PRY

- REPL: Read-eval-print-loop - Permite executar código Ruby direto pelo promp de comando. Alternativas:
- - IRB: Interactive Ruby Shell
- - PRY: É uma Ruby Gem parecido com o IRB, porém, há recursos adicionais como: Destaque de sintaxe, preenchimento automático, depuração, etc...

## Array e Hash

### Array

É uma coleção ordenada por qualquer objeto indexado por um inteiro. Cada elemento do array é referenciado e indexado por um índice.

```ruby
# Criando Array. Quantia de elementos não definido
# Variáveis com nome snake_case
array_a = []
array_b = Array.new
array_c = %w("Cada palavra se torna um elemento indexado")

# Inserindo dados. Permite diferente tipos de dados
array_a.push(777)
array_a.push("ruby")
array_a[2] = true

# Acessando array
array_a
array_a[0]
array_a.at(1)
```

### Hash

É uma coleção de pares chave-valor. É similar ao array, porém, seus índices são definidos arbitráriamente. As chaves devem ser String ou Symbol.

```ruby
# Criando hash
hash_a = {
    "chave_a" => "valor",
    "chave_b" => 123,
    "chave_c" => false
}

# Symbol (Conteúdo mais à frente)
hash_b = {
    :chave_a => "valor",
    :chave_b => 123,
    :chave_c => false
}

# Retorna a 'key' como symbol
hash_c = {
    chave_a: "valor",
    chave_b: 123,
    chave_c: false
}

# Acessando hash
hash_a
hash_a["chave_a"]
hash_c[:chave_a]
```

## Métodos

Métodos são blocos de código que realizam uma tarefa específica e podem ser reutilizados em diferentes partes de um programa. Eles são semelhantes a funções em outras linguagens de programação.

Um método pode retornar um valor usando a palavra-chave _return_. Se _return_ não for usado explicitamente, o método retorna o valor da última expressão avaliada.

Parâmetros são as variáveis que a função espera receber. Argumentos são os valores passados à essas variáveis.

```ruby
# Criando método
def retorna_cinco # Parâmetros são opcionais
    3 + 2 # Retorno implícito
end

def hello(txt)
    puts "hello #{txt}"
end

def world txt
    puts "hello " + txt
end

def saudacao(nome = "Visitante") # Parâmetro com valor padrão
    puts "Olá, #{nome}!"
end

def somar(*args) # Quantia variável de parâmetros
    total = 0

    args.each do |num|
        total += num
    end

    return total
end

# Chamando método
puts retorna_cinco # É possível chamar métodos sem a notação "()"
hello("world")
hello # ERROR - ArgumentError / Nenhum argumento foi passado
world "world"
saudacao
saudacao("John Doe")
puts somar(1, 2, 3)

# OBS: Método com blocks mais à frente
```

## Closures

Closure é uma função ou um bloco de código com variáveis ​​que são vinculadas ao ambiente em que o closure foi chamado. Ou em outras palavras, closure pode ser tratado como uma variável que pode ser atribuída a outra variável ou pode ser passada para qualquer função como um argumento.

Closure é uma funcionalidade que permite escrever um pedaço de código que pode ser:

- Utilizado como um valor (podendo ser atribuído, passado como parâmetro, etc.)
- Pode ser executado em qualquer lugar
- Referenciam variáveis no contexto onde são criados

> Em Ruby, blocks, procs e lambda são closures.

### Blocks, Procs e Lambda

Procs e Lambdas são um tipo de função anônima que geralmente utilizam variáveis do escopo pai e que podem ser atribuídas a variáveis, o que define de forma simples o conceito de Closure e executam blocos de código (Blocks).

#### Blocks

Ruby blocks, "são pequenas funções anônimas que podem ser passadas nos métodos". Podemos identificar Ruby Blocks quando vemos ou escrevemos no código comandos dentro dos **do...end** ou entre chaves **{block}** e os argumentos vão dentro de pipes **|args|**. Métodos famosos como o _.each_ e _.times_ são bons exemplos de Blocks.

```ruby
# Sintaxe "do...end"
#  block_name do
#    #statement-1
#    #statement-2
# end

[1, 2, 3, 4, 5].each do |num|
    p num # p = puts
end

# Sintaxe {} - Bloco inline
#  block_name { #statements_to_be_executed }

meu_block { puts "Hello, world!" }
```

#### Procs

Uma Proc é associada a uma variável e executada com o método **.call**. As Procs tem algumas particularidades, a mais notável é o fato dos argumentos **não** interferirem na execução da mesma.

> Procs preenche os argumentos ausentes com _nil_ e um único argumento de array é desconstruído se o proc tiver vários argumentos.

```ruby
# Criando proc
a = Proc.new {|x, y| "x = #{x}, y = #{y}" }
b = Proc.new { "Hello, world!" }

# Executando proc
puts a.call(1, 2)       # Saída: x = 1, y = 2
puts a.call([2, 1])     # Saída: x = 2, y = 1
puts a.call(3, 4, 8)    # Saída: x = 3, y = 4
puts a.call(9)          # Saída: x = 9, y =
puts a.call             # Saída: x = , y =
```

#### Lambda

Lambda e Procs são bem parecidos. Além disso, podemos dizer que uma lambda é uma forma de definir um bloco e seus parâmetros com uma sintaxe especial. A lambda é como um método comum porque impõe o número de parâmetros quando é chamado e também retorna como um método normal (trata a palavra-chave _return_ da mesma forma que os métodos).

Se você passar um parâmetro para uma lambda que não o espera, você receberá um ArgumentError.

```ruby
# Criando lambda
lambda_a = -> {puts "Hey"}
lambda_b = -> (x) {puts "Hello! " + x}

# Chamando lambda
lambda_a.call
lambda_b.call("GeeksforGeeks")
```

## Recebendo blocos como argumento

### yield

O yield para a execução do método e passa o controle para o bloco que foi passado como parâmetro pelo método. Na prática, serve para inserir blocos de código dentro dum método.

```ruby
# Criando função
def minha_funcao
    puts "a"
    yield
    # yield if block_given? # Caso não seja inserido nenhum bloco, não haverá erro
    puts "c"
end

# Inserindo block
# minha_funcao { puts "b" }
minha_funcao do
    puts "b"
    # ...
end
```

## Classes

Classes são modelos de objetos que irão receber características próprias.

Em Ruby, tudo é objeto, inclusive números! Para saber a classe do objeto, utilize o método **.class**.

> NOTA: Utilize 'require' para importar uma classe para o arquivo atual.

```ruby
# Criando classe (Classes com nome PascalCase)
class Pessoa
    def falar(txt)
        puts "Fulano disse: #{txt}"
    end
end

# Instânciando classe
pss = Pessoa.new
pss.falar "Lorem Ipsum"

# Herança
class Atleta < Pessoa
    def correr
        puts "Fulano correu!"
    end
end

att = Atleta.new
att.falar "Lorem Ipsum"
att.correr
```

### Escopo "privado / private"

Em Ruby, os atributos e métodos de uma classe fazem parte de um escopo.

```ruby
class Pessoa
    def falar(txt)
        respirar
        puts "Fulano disse: #{txt}."
    end

    private
      def respirar
        puts "Fulano respirou."
      end
end
```

## Módulo

Módulo é uma coleção de métodos e constantes.

> NOTA: É uma convenção utilizar SCREAMING_SNAKE_CASE no nome das constantes. Utilize 'include' para que a classe tenha acesso ao módulo.

```ruby
# Criando módulo
module Sobre
    LINGUAGEM_UTILIZADA = "Ruby"
    VERSAO = "3.1.1"

    def somar(x, y)
        x + y
    end
end

# Acessando módulo
Sobre::VERSAO
```

## Mixin

Ruby não suporta herança múltipla diretamente, mas **módulos** Ruby podem ter outros usos maravilhosos. Eles praticamente eliminam a necessidade de herança múltipla, proporcionando um mecanismo chamado Mixin.

```ruby
# Criando módulos
module Calculadora
    def calcular
        puts "Resultado: x"
    end
end

module Email
    def enviar_email
        puts "Email enviado"
    end
end

# Criando mixin
class MeuMixin
    include Calculadora
    include Email
end

# Utilizando Mixin
mm = MeuMixin.new
mm.calcular
mm.enviar_email
```

## Symbols x Strings

Simbolo é todo objeto iniciado por dois pontos (:) seguido por uma palavra qualquer. Texto é uma string contida entre aspas simples ou duplas.

O método **\*.object_id** retorna o _id_ único do objeto, inclusive strings e inteiros. Por mais que o _conteúdo_ da string, por exemplo, seja o mesmo, o object*id será diferente. Porém, o **object_id** de um \_symbol* será o mesmo. Ou seja, a string é repetida na memória quando declarada com o mesmo conteúdo, mas o symbol não.

> OBS: Symbols que requerem caracteres especiais (inclusive espaços), utilize aspas. Ex.: :'pt-BR'

```ruby
# Symbol
:my_text.class # Saída: String
:my_text.object_id # Saída: 984808
:my_text.object_id # Saída: 984808
:my_text.object_id # Saída: 984808

# Texto
"my_text".class # Saída: Symbol
"my_text".object_id # Saída: 835345435
"my_text".object_id # Saída: 825124463
"my_text".object_id # Saída: 865434534
```

# Gemas

> TODO

## Como instalar

> TODO

# Ruby on Rails

[Descrição dos métodos](https://apidock.com/rails)

## História

Ruby on Rails (ou simplesmente Rails) é um framework de desenvolvimento web escrito em Ruby, lançado em 2004 por David Heinemeier Hansson (também conhecido como DHH) e a versão 1.0 foi lançada em dezembro de 2005. Ele foi criado como parte do desenvolvimento da ferramenta de gerenciamento de projetos Basecamp pela empresa 37signals (hoje Basecamp).

Características:

- Arquitetura MVC
- Generator
- Servidor embutido

## Estrutura de pastas

- app/: Onde fica a aplicação MVC
- bin/: Scripts
- config/: Configuração
- db/: Banco de dados
- lib/: Módulos extendidos da aplicação
- log/: Registro de ações (log)
- public/: Pasta pública para usuário final, arquivos estáticos
- store/: Banco de Dados SQLite e ActiveRecord (ORM)
- test/: TDD (Test-Driven-Development)
- tmp/: Arquivos temporários gerado automaticamante, como, seções, conexões, cache, cookies, etc..
- vendor/: Plugins de terceiros (inclusive gems)

## Arquivos

- Gemfile(.lock): Lista de gems que a aplicação necessita. São gerenciadas pelo Bundler (rubygems.org)
- Rakefile: Contém as tarefas a serem executadas. Se estiver utilizando Rails, adicione as tarefas em 'lib/tasks'

## Arquitetura

> TODO

## Comandos

- rails new nome_do_projeto: Cria um novo projeto Rails
- - rails new nome_do_projeto --database=ADAPTADOR: Altera o banco de dados da aplicação (SQLite3 é o padrão. É possível modificar posteriormente)
- rails server (ou apenas "s"): Inicia o projeto
- - rails s -e [production | development | test]: Altera o modo de execução da aplicação
- rails generate [model | view | controller | scaffold | etc..] <name?>
- rails console (ou apenas "c"): Prompt de comando para a aplicação Rails. Todas as classes presentes no app Rails são carregadas e ficam prontas para uso no console.
- rails db:[create | migrate | seed]: TODO
- rails assets:precompile: TODO

## Banco de Dados

Para configurar o banco de dados, modifique o arquivo **config/database.yml**.

### Rake (Contexto Rails)

É uma gema para gerenciamento de tarefas. Contém scripts geradores úteis para aplicações Rails.

#### Comandos

- rake db:create - Cria o banco de dados de acordo com o **config/database.yml** (DB de produção deve ser especificado)

## CoC (Convention over Configuration)

É um paradigma de projeto que visa diminuir o número de decissões que os desenvolvedores devem fazer, ganhando simplicidade sem perder a flexibilidade.

Em Rails, os comandos geradores de models, views, controlers, schemas, etc. é um CoC, pois, não há a necessidade de desenvolver todo um código _boilerplate_.

### Scaffold (Andaime)

No contexto Rails é como se o app recém gerado estivesse pré-moldado para que você o personalize, sem a necessidade de criá-lo do absoluto zero.

Gera os arquivos necessários (MVC) e configura as rotas para realizar CRUD da entidade criada e também o arquivo de _migrate_. É necessário realizar a migração para o banco de dados (próx. conteúdo).

![Scaffold](./images/Scaffold.jpeg)

> OBS: O nome do modelo é no singular, mas no banco de dados é no plural (convenção).

```shell
# Para criar um Scaffold, utilize o seguinte comando
rails generate scaffold nome:tipo nome:tipo nome:tipo ...
```

## Migration

A troca de informações entre o Banco de Dados e a aplicação Rails é realizada através das _migrates_.

Além dos campos criados pelo programador, o arquivo _migrate_ também cria alguns campos, são eles:

- id: Chave primária do tipo autoincremento
- timestamps: Gera dois campos, created_at e updated_at. São atualizados automaticamente.

```shell
# Deixa o banco de dados igual ao script schema. A tabela pode ser criada, modificada ou removida
rake db:migrate
```

## Views

> NOTA: Toda view, partial, etc.. Passa por app/views/application.html.erb. Ao utilizar prompts generators para framework front-end, o nome do "application" é 'application' (nome do root da view).

### Embedded Ruby

É um sistema de template que combina a linguagem Ruby com texto. Sua extensão é **\*.erb**.

Tags

- <% %>: Código ruby sem saída para HTML
- <%= %>: Código ruby cujo retorno será impresso no HTML
- <%= -%>: Código ruby cujo retorno será impresso no HTML, porém, remove a quebra de linha final
- <%# %>: Comenta o código ruby, pode estar junto de = e -.

### Interpolação de váriaveis em texto

Adiciona o valor duma variável na string.

```ruby
variavel = "interpolado"
"Minha string #{variavel}" # Saída: Minha string interpolada

<%= "Interpolando em embedded ruby: #{variavel}" %>
```

### Partials

São arquivos com a extensão _.html.erb_ cujo nome começam com underline (\_).

```shell
# app/view/customer/new.html.erb
<%= render "form" %>

# app/view/customer/_form.html.erb (É um "mini-controller" contém lógica de
# programação e renderização. No contexto React, seria como um componente.) ...
```

## Models

Quando um modelo herda de _ActiveRecord::Base_ (notação de módulo), há uma comunicação com o Banco de Dados gerando as informações na mesma. Active Record é um ORM (Object Relational Mapping).

## Controllers

Local onde está presente as **ações** do sistema. Para toda _ação_, haverá uma _view_ relacionada a ação.

O arroba "@" antes do nome da variável indica que a variável é uma variável de instância. Em Rails, ao criar uma variável de instância no controller, a view também terá acesso a ela.

> OBS: O nome da _view_ **deve** ser o mesmo do método do _controller_.

```ruby
# Controller "customers_controller.rb"
def index
    @customers = Customer.all
end

# View "customers/index.html.erb"
<% @customer.each do |customer| %>
    <%= customer.name %>
<% end %>
```

### before_action x before_filter

> São o mesmo elemento. before_filter até rails 3.x e before_action >= 4.x.

Em Rails, filtros são métodos que são executados antes, depois ou ambos os casos (around) de uma ação de controle. Evita repetição de código (DRY).

```ruby
# before_action :method_name, only: [:method_name, :method_name]

class Customer < ApplicationController
  # OBS: São filtros exclusivo do *Rails*
  before_action :set_customer, only: [:hello]

  def hello
    puts customer.name
  end

  private
    def set_customer
      @customer = {id: 1, name: "John Doe", email: "example@email.org"}
    end
end
```

## Rotas

> config/routes.rb

Arquivo que determina as rotas (e verbos) da aplicação. A url "/rails/info/routes" mostra todas as rotas disponíveis no aplicativo.

```ruby
# [get | post | put | patch | delete | options] "nome_da_rota" => "view#action"
get "inicio" => "welcome#index"

# Rota padrão (raiz), index da aplicação
root "view#action"
```

### Recuperando parâmetros

Dentro de um _Controller_, acesse o _hash_ **params**.

```ruby
# 'Customer' é um modelo exemplo. 'find()' é um método 'read' do ActiveRecord
# ':id' é um symbol criado na rota. Ex.: GET /users/:id
Customer.find(params[:id])
```

### REST / RESTful

REST (Representational State Transfer) é um estilo de arquitetura de software para sistemas distribuídos, amplamente usado em **APIs web**. Ele se baseia em princípios como:

- Recursos: Tudo é tratado como um recurso (por exemplo, usuários, produtos) identificado por URLs.
- Métodos HTTP: Usa verbos como GET (ler), POST (criar), PUT/PATCH (atualizar) e DELETE (remover) para operações.
- Stateless: Cada requisição é independente e contém todas as informações necessárias.
- Representações: Os recursos/respostas podem ser representados em formatos como JSON ou XML.

Em resumo, REST é uma forma simples e eficiente de criar APIs que seguem padrões claros e escaláveis.

> Adiciona semântica nas requisições web.

### Helpers

São comandos **Rails** para ajudar o desenvolvedor.

Utilitários:

- link*to: Substitui o "href" do elemento \_anchor*
- [Lista completa](https://guides.rubyonrails.org/action_view_helpers.html)

```
# View - link_to(name, path)
<%= link_to "Texto", :action => "action_name" %>

# <%= link_to "Texto", "/customers" %> >> 'customers_path' é gerado automaticamente pelo Rails (/rails/info/routes)
<%= link_to "Texto", customers_path %>
```

## Active Record

> Active Record também é um padrão de projeto para Banco de Dados relacionais.

Active Record é um framework presente no Ruby on Rails e é responsável por tratar a persistência das informações no Banco de Dados.

Active Record permite o desenvolvedor crie DBs sem necessitar de SQL, pois, utiliza DSL (Doman Specif Language)

```ruby
# Operações CRUD
# Create
model = <Model>.create(name: "John Doe", age: 20) # Cria o objeto no Banco de Dados e retorna a instância do modelo criado
model = <Model>.new(name: "John Doe", age: 20) # Instância o objeto e depois salva no banco de dados
model.save

# Read
<Model>.all # Retorna um array
<Model>.last # Retorna o último elemento
<Model>.where(name: :Josivaldo) # Filtra os objetos e retorna um array. Argumento é 'hash'
<Model>.find(:id => 1) # Filtra os objetos e retorna um único elemento. Argumento é 'hash'
```

## i18n (Internationalization)

Maneira simplificada para traduzir páginas Rails.

Para modificar a _locale_ padrão, altere "config/application.rb" em "config.i18n.default_locale".

Observações:

- Tradução: Traduzir textos
- Localização: Localizar data/hora/moeda (Requer tradução, veja link a seguir)

[i18n de data em pt-BR](https://github.com/svenfuchs/rails-i18n/blob/master/rails/locale/pt-BR.yml)

```ruby
# NOTA: Caso a chave não seja encontrada, será renderizado o nome da chave e não seu valor.

# Tradução em métodos
i18n.t('caminho.da.chave') # Tradução
i18n.l() # Localização

# Tradução nas views
t(:'caminho.da.chave') # Tradução
l() # Localização
```

## Framework front-end

### Twitter Bootstrap

Framework web front-end para desenvolver aplicativos responsivos. Acesse [aqui](https://getbootstrap.com/2.0.2/).

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

# TODO

- Ruby-Toolbox [Clique aqui](https://www.ruby-toolbox.com/)

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

- `rails new <nome_do_projeto>`: Cria um novo projeto Rails
  - `rails new <nome_do_projeto> --database=ADAPTADOR`: Altera o banco de dados da aplicação (SQLite3 é o padrão. É possível modificar posteriormente)
  - `rails new <nome_do_projeto> --api`: Cria um app Rails como API
  - `rails new <nome_do_projeto> --css tailwind`: Cria um app Rails com Tailwind
- `rails server` (ou apenas "s"): Inicia o projeto
  - `rails s -e [production | development | test]`: Altera o modo de execução da aplicação
- `rails generate`: Mostra todos os comandos "generate"
- `rails generate [model | view | controller | scaffold | etc..] <nome>`
- `rails destroy [model | view | controller | scaffold | etc..] <nome>`
- `rails console` (ou apenas "c"): Prompt de comando para a aplicação Rails. Todas as classes presentes no app Rails são carregadas e ficam prontas para uso no console.
- `rails db:[create | migrate | seed | rollback]`: TODO
- `rails assets:precompile`: TODO

> Nota: Adicione `RAILS_ENV=[production | development | test]` para modificar o ambiente de execução do comando

## Banco de Dados

Para configurar o banco de dados, modifique o arquivo **config/database.yml**, nele contém instruções de como configurar de acordo com o Banco de Dados selecionado.

Se você tiver um arquivo `config/database.yml` vazio, mas a variável de ambiente `ENV['DATABASE_URL']` estiver definida, o Rails irá se conectar ao banco de dados por meio dessa variável de ambiente.

Prioridade:

- Variável de ambiente
- config/database.yml

```shell
# Altera o driver do Banco de Dados
bin/rails db:system:change --to=[postgresql | mysql |sqlite3]
```

### Rake (Contexto Rails)

> OBS: comandos _rails db:[create | migrate | seed]_ servem como proxys de comandos rakes a partir da versão 5 do Rails, ou seja, ao utilizar _rails db:create_, você estará utilizando _rake db:create_ "por baixo dos panos".

É uma gema para gerenciamento de tarefas. Contém scripts geradores úteis para aplicações Rails.

> Comando _rake -T_ mostra todos os rake task do projeto. Para filtrar, utilize _rake -T db_ e tudo que começar com "db" será mostrado.

```shell
# Sintaxe

# rake namespace:rake_task
rake db:create
```

#### Criando Rake Task

As tasks geradas pelo comando generate são salvas em _lib/tasks/_ com a extensão _.rake_

> Comando: _rails generate task [namespace] [task_name]_

```ruby
# rails generate task utils say_hello
# lib/tasks/utils.rake
namespace :utils do
  desc "Say Hello World n times"      # Descrição ao utilizar 'rake -T'
  task say_hello: :environment do
  # Algoritmo
    if Rails.env.development?     # Verifica o ambiente
      ENV['QTD'].to_i.times do |i|     # Valor da chave 'QTD' ao utilizar o comando rake (ARGV contém todos argumentos)
        puts "Hello World"
      end
    end
  end

  # Para adicionar mais uma rake task a este namespace, copie e modifique o bloco a cima
end

# Comando: rake utils:say_hello QTD=10
```

#### Comandos

- rake db:create - Cria o banco de dados de acordo com o **config/database.yml** (DB de produção deve ser especificado)
- rake db:migrate - Gera as tableas de acordo com os models da aplicação
- rake db:seed - Popula tabelas com informações pré-definidas. Casos de uso: Tabelas auxiliares como lista de bancos suportados, cidades, etc. (Arquivo db/seeds.rb)

## CoC (Convention over Configuration)

É um paradigma de projeto que visa diminuir o número de decissões que os desenvolvedores devem fazer, ganhando simplicidade sem perder a flexibilidade.

Em Rails, os comandos geradores de models, views, controlers, schemas, etc. é um CoC, pois, não há a necessidade de desenvolver todo um código _boilerplate_.

### Scaffold (Andaime)

No contexto Rails é como se o app recém gerado estivesse pré-moldado para que você o personalize, sem a necessidade de criá-lo do absoluto zero.

Gera os arquivos necessários (MVC) e configura as rotas para realizar CRUD da entidade criada e também o arquivo de _migrate_. É necessário realizar a migração para o banco de dados (próx. conteúdo).

![Scaffold](/assets/images/Scaffold.jpeg)

> OBS: O nome do modelo é no singular, mas no banco de dados é no plural (convenção).

```shell
# Para criar um Scaffold, utilize o seguinte comando
rails generate scaffold Modelo nome:tipo nome:tipo nome:tipo ...
rails g scaffold Article title:string body:text
```

#### Adicionando/removendo campos

```shell
# Sintaxe
# Troque YYY pelo nome do model. Adicione o "s" em "Field" caso seja mais de um campo
rails generate migration AddFieldToYYY nome:tipo    # PascalCase
rails generate migration remove_xxx_from_yyy        # snake_case

# Exemplo
rails g migration addNameToPerson name:string

# Aplicando modificações no Banco de Dados
rake db:migrate
```

> É preciso permitir os novos campos no controller para realizar atualizações nas requisições

## Migration

A troca de informações entre o Banco de Dados e a aplicação Rails é realizada através das _migrates_.

Além dos campos criados pelo programador, o arquivo _migrate_ também cria alguns campos, são eles:

- id: Chave primária do tipo autoincremento
- timestamps: Gera dois campos, created_at e updated_at. São atualizados automaticamente.

```shell
# Deixa o banco de dados igual ao script schema. A tabela pode ser criada, modificada ou removida
rake db:migrate
```

### Operações em tabelas

- add_column
- remove_column
- rename_column
- change_column

```ruby
# Tornando `change_column` reversível

# Método 1
class ChangeTypeOfDescriptionInDemos < ActiveRecord::Migration[6.1]
  def change
    reversible do |dir|
      # Será executado em `db:migrate`
      dir.up do
        change_column :demos, :description, :text
      end

      # Será executado em `db:rollback`
      dir.down do
        change_column :demos, :description, :string
      end
    end
  end
end

# Método 2
class ChangeTypeOfDescriptionInDemos < ActiveRecord::Migration[6.1]
  def up
    change_column :demos, :description, :text
  end

  def down
    change_column :demos, :description, :string
  end
end
```

### Migração específica

> NOTA: Observe que "VERSION=" é o **timestamp** da migração.

```shell
# Migração específica
rails db:migrate:up VERSION=20251225246060

# Rollback específico
rails db:migrate:down VERSION=20251225246060

# Quantia de rollbacks
rails db:rollback STEP=n

# Quantia de migrações a partir da última definida no "schema"
rails db:migrate:redo STEP=n

```

## Views

> NOTA: Toda view, partial, etc.. Passa por app/views/application.html.erb (root da view).

### Embedded Ruby

É um sistema de template que combina a linguagem Ruby com texto. Sua extensão é **.erb**.

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

```ruby
# app/view/customer/new.html.erb
<%= render "form" %>

# NOTA: Caso a view tenha acesso á variavel @user, a partial também terá automaticamente
<%= render "form", @user %>

<%= render "form", user: @user %>
<%= render partial: "form", locals: { user: @user } %>

# app/view/customer/_form.html.erb (É um "mini-controller" contém lógica de
# programação e renderização. No contexto React, seria como um componente.) ...
```

### Formulário

`form_with` Substitui form_for e form_tag. Usa sempre `FormBuilder`.

```ruby
# Com model
<%= form_with model: @user do |f| %>
  <%= f.text_field :name %>
  <%= f.submit %>
<% end %>

# Sem model
<%= form_with url: "/login" do |f| %>
  <%= f.text_field :email %>
  <%= f.submit %>
<% end %>
```

```ruby
# Select
# OBS: {include_blank: [true | false | "string_placeholder"]}
select("model_name", "attribute", %w(option option option), {include_blank: true})

# "f" representa o model no closure "form_for". ":attribute" é o symbol com o nome do atributo do model. "@person.sex" altera o "M" para "Masculino" (neste caso) para quando for modificar o model
f.select(:attribute, options_for_select([["Masculino", "M"], ["Feminino", "F"]], @person.sex), {include_blank: "Selecione"})

# Collection select
# f.collection_select(nome_do_campo, modelos_para_popular, valor, nome_da_option, include_blank)
f.collection_select(:model_id, @models, :id, :name, include_blank: true)

# OBS: "include_blank" pode ser substituido para "prompt" que contém uma mensagem padrão. Evite chamar o model dentro da view, utilize uma variável que contenha a informação desejada
```

#### field helpers

São métodos do FormBuilder.

Campos de texto e numéricos:
- text_field
- text_area
- number_field
- range_field
- password_field
- email_field
- telephone_field
- url_field
- search_field

Campos de data e tempo:
- date_field
- time_field
- datetime_field
- datetime_local_field
- month_field
- week_field

Campos de seleção:
- select
- collection_select
- grouped_collection_select
- time_zone_select

Campos booleanos:
- check_box
- radio_button

Upload e arquivos:
- file_field

Campos ocultos e auxiliares:
- hidden_field
- color_field

Campos de envio e ação:
- submit
- button

#### Formulários complexos e Nested Attributes

**Problemática**: Ao criar um usuário através de um formulário com os campos "Nome, e-mail e telefone" e "Endereço, cód. postal, referência", como saber quais dados são do modelo Usuário e quais dados são do modelo Endereço?

Quando um modelo tem o helper **has_one** (no caso, Usuário tem apenas um endereço) o método **build\_\*** (\* é o nome do modelo) fica acessível para o modelo. O método faz com que ao criar o Endereço e salvar o usuário sejam salvos duas entidades diferentes no banco de dados.

> É preciso atualizar o controller para permitir os novos campos vindo do formulário.

```ruby
# OBS: As classes contém construtor apenas para demonstrar os seus atributos

# Criando classes
class Usuario
  attr_accessor :nome, :email, :telefone
  has_one :endereco
  accepts_nested_attributes_for :endereco

  def initialize(nome, email, telefone)
    self.nome = nome
    self.email = email
    self.telefone = telefone
  end
end

class Endereco
  attr_accessor :endereco, :cep, :referencia
  belongs_to :usuario

  def initialize(endereco, cep, referencia)
    self.endereco = endereco
    self.cep = cep
    self.referencia = referencia
  end
end

# Criando sem "accepts_nested_attributes_for"
usuario = Usuario.new(nome: "John Doe", email: "johndoe@email.com", telefone: "12345678")
usuario.build_endereco(endereco: "Rua A", cep: "87654321", referencia: "Padaria")

# Criando com "accepts_nested_attributes_for"
usuario = Usuario.new(nome: "John Doe", email: "johndoe@email.com", telefone: "12345678", endereco_attributes: {endereco: "Rua A", cep: "87654321", referencia: "Padaria"})
```

```ruby
# Controller
def new
  @usuario = Usuario.new
  @usuario.build_endereco # Novo
end
```

### Conteúdo head personalizado

Dentro da tag head em _app/views/layouts/application.html.erb_ adicione **<%= yield :head %>** e dentro da view, adicione o bloco **content_for :head do**. Adicione o _yield_ na primeira linha da tag head.

```html
<!-- app/views/layouts/application.html.erb -->
<head>
  <%= yield :head %>
  <!-- ... -->
</head>
```

```html
<!-- app/views/minha_view/index.html.erb -->
<% content_for :head do %>
<title>A simple page</title>
<% end %>
<p>Hello, Rails!</p>
```

## Models

Quando um modelo herda de _ActiveRecord::Base_ (notação de módulo), há uma comunicação com o Banco de Dados gerando as informações na mesma. Active Record é um ORM (Object Relational Mapping).

> OBS: É possível criar métodos personalizados dentro do model.

```ruby
class Person < ApplicationRecord
  def hello
    "Hello!!"
  end
end
```

### Validadores

> Validações não substituem constraints do banco. Para integridade real, use índices únicos, NOT NULL e foreign keys no banco de dados.

| Categoria     | Validadores                  |
| ------------- | ---------------------------- |
| Presença      | `presence`, `absence`        |
| Exclusividade | `uniqueness`                 |
| Tamanho       | `length`                     |
| Número        | `numericality`               |
| Formato       | `format`                     |
| Conjunto      | `inclusion`, `exclusion`     |
| Confirmação   | `confirmation`, `acceptance` |
| Associação    | `validates_associated`       |
| Customizado   | `validate`                   |

```ruby
validates :name, presence: true
validate :validate_age    # Validador personalizado

def validate_age
  if self.date_of_birth.present?
    age = Date.today.year - self.date_of_birth.year

    if age < 18
      errors.add " must be greater than 18 years old"
    end
  end
end
```

### Associações

- `has_one`: Relação 1 para 1
- `has_many`: Relação 1 para N
- `belongs_to`: Pertence a outro modelo. Deve conter uma FK
- `has_and_belongs_to_many`: Relacionamento N para N usando uma tabela intermediária, porém, sem modelo
- `has_many :through`: Relacionamento N para N usando uma tabela intermediária e um modelo. Permite atributos extras e callbacks
- `has_one :through`: Relacionamento 1 para 1 indireto

> TODO: Associações polimórficas & pesquisar por `dependent: :destroy`

![Associação](/assets/images/Associacao.jpeg)

> Associações/referências dentro de tabelas em Ruby seguem a seguinte convenção: model-name_id. Lembre-se que o nome dos models são no **singular** (as tabelas ficarão no plural) e o "\_id" será adicionado automaticamente.

No exemplo acima, "Child" belongs_to "Father" e "Father" has_many "Child".

```shell
rails g model Father name:string
rails g model Child name:string father:references

# OBS: É preciso adicionar "has_many :child" no model Father
```

Para controlar os modelos com Orientação a objetos, é possível fazer da seguinte forma:

```ruby
pai = Father.create(name: "John Doe")
filho = Child.create(name: "Junior Doe")

filho.father = pai  # Necessário para salvar o modelo
filho.save!

# ou

father.children.create(name: "Maria Doe")
```

#### has_and_belongs_to_many

É utilizado para estabelecer um relacionamento muitos-para-muitos entre dois modelos, sem a existência de um modelo intermediário. Esse relacionamento requer uma tabela de junção dedicada no banco de dados, que armazena apenas as chaves estrangeiras dos dois modelos associados e não possui chave primária própria, modelo correspondente nem atributos adicionais.

Requer que a join table seja criada através duma migration. O nome da tabela deve ser o nome dos dois modelos pluralizado e em ordem alfabética, e sem *primary key*.

> NOTA: Prefira `has_many :through`.

#### Through

Uma associação [has_many | has_one] :through é frequentemente usada para configurar um relacionamento muitos-para-muitos (ou um-para-um) com outro modelo/entidade.

> Gem recomendada: Cocoon

```ruby
class Medico < ApplicationRecord
  has_many :consulta
  has_many :pacientes, through: :consulta
end

class Paciente < ApplicationRecord
  has_many :consulta
  has_many :medicos, through: :consulta
end

class Consulta < ApplicationRecord
  belongs_to :medico
  belongs_to :paciente
end
```

#### Polymorphic association

São modelos que pode pertencer a mais de um modelo.

Em uma associação polimorfica, o modelo "filho" (ex: Comentário) armazena não apenas o ID do "pai", mas também o Tipo (nome da classe) do pai.

```ruby
# rails g model Comment content:text commentable:references{polymorphic}
class Comment < ApplicationRecord
  # Por convenção, usamos um nome que termine em "-able"
  belongs_to :commentable, polymorphic: true
end

class Event < ApplicationRecord
  has_many :comments, as: :commentable
end

class Article < ApplicationRecord
  has_many :comments, as: :commentable
end

class News < ApplicationRecord
  has_many :comments, as: :commentable
end

comment = Comment.first
comment.event             # Error
comment.article           # Error
comment.news              # Error
comment.commentable       # [Event | Article | News] object
Event.first.comments      # Lista de Comment
```

### Callbacks

Os Callbacks são ganchos (hooks) no ciclo de vida de um objeto ActiveRecord que permitem a execução de lógica antes ou depois de alterações específicas no estado desse objeto (como criar, atualizar ou deletar).

Eles são ferramentas poderosas para manter a integridade dos dados e automatizar tarefas, como formatar uma string antes de salvar ou disparar um e-mail após a criação de um registro.

Lista

- before_validation
- after_validation
- before_save
- around_save
- before_[create | update | destroy]
- around_[create | update | destroy]
- after_[create | update | destroy]
- after_save
- after_commit / after_rollback
- after_initialize
- after_find
- after_touch: Chamado quando você executa o método `touch` no objeto

> NOTA: `after_save` é acionado mesmo que ocorra um erro. Para ações que devem ser acionadas apenas após o sucesso (como enviar e-mail), utilize `after_commit`

#### Service Object

Problematica: Toda vez que você criar um usuário em um teste ou no console, ele tentará enviar e-mails e logs. Isso deixa os testes lentos e acopla o modelo a serviços externos.

Um Service Object é uma classe simples (POJO - Plain Old Ruby Object) que executa uma única ação de negócio. Remove a lógica de "efeito colateral" do modelo. O modelo agora só cuida dos dados.

```ruby
# app/models/user.rb
class User < ApplicationRecord
  # Apenas validações e associações aqui
  validates :email, presence: true
end

# app/services/user_registration_service.rb
class UserRegistrationService
  def initialize(user_params)
    @user_params = user_params
  end

  def call
    user = User.new(@user_params)

    if user.save
      # A lógica de "depois de criar" fica aqui, fora do model!
      UserMailer.welcome(user).deliver_later
      ExternalLogger.log("Novo usuário: #{user.email}")
      return user
    else
      return nil
    end
  end
end

# app/controllers/users_controller.rb
def create
  @user = UserRegistrationService.new(user_params).call

  if @user
    render json: @user, status: :created
  else
    render json: { errors: "Erro ao criar usuário" }, status: :unprocessable_entity
  end
end
```

> TODO: Service Object usando RSpec (Testes)

### Mensagens de erros personalizadas

> TODO

### Enum

```ruby
class Conversation < ActiveRecord::Base
  # Cria um enum cujo valor no Banco de Dados será o 'key' do 'value'
  enum status: [:active, :archived]
end

# Gera métodos para definir e checar automaticamente
conversation.active!    # Define o valor de "status" para active (0)
conversation.archived!  # Define o valor de "status" para archived (1)
conversation.active?    # Retorna "true" ou "false" dependendo do valor do "status"
conversation.status     # Saída: "archived"
```

## Controllers

O controller é o componente responsável por receber requisições HTTP, orquestrar a lógica da aplicação e retornar uma resposta ao cliente (HTML, JSON, redirecionamento, etc.). São compostos por actions, que são métodos públicos associados a rotas. Por convenção, utilizam actions RESTful, promovendo padronização e previsibilidade.

Boas práticas recomendam controllers enxutos, contendo apenas lógica de fluxo, validação básica e controle de resposta, delegando regras de negócio para outras camadas da aplicação.

> OBS: O nome da _view_ **deve** ser o mesmo do **método** do _controller_, no caso, index.

```ruby
# Controller "customers_controller.rb"
def index
    # Carrega TODOS os registros de uma vez em memória. Alto consumo de memória
    @customers = Customer.all

    # Alternativas performáticas

    # .find_each: Processamento interno / batch / jobs
    # - Ignora `order` customizado
    # - Ignora `limit`
    # - Requer `id` incremental
    @customers = Customer.find_each

    # keyset pagination: Listagem incremental / API / UI
    @customers = Customer.where("id > ?", last_id).order(:id).limit(20)
end

# View "customers/index.html.erb"
<% @customers.each do |customer| %>
    <%= customer.name %>
<% end %>
```

### Ações (Actions)

São **métodos públicos** responsáveis por responder a requisições HTTP. Por convenção, Rails fornece um conjunto padrão de actions RESTful, especialmente quando usamos resources no roteamento.

```ruby
# Lista todos os recursos (GET)
def index
  @users = User.all
end

# Exibe um recurso específico (GET)
def show
  @user = User.find(params[:id])
end

# Exibe o formulário para criar um novo recurso (GET)
def new
  @user = User.new
end

# Cria um novo recurso no banco de dados (POST)
def create
  @user = User.new(user_params)
  @user.save
end

# Exibe o formulário para editar um recurso existente (GET)
def edit
  @user = User.find(params[:id])
end

# Atualiza um recurso existente (PATCH / PUT)
def update
  @user = User.find(params[:id])
  @user.update(user_params)
end

# Remove um recurso (DELETE)
def destroy
  @user = User.find(params[:id])
  @user.destroy     # Ativa callbacks do ActiveRecord
  # @user.delete    # Ignora callbacks do ActiveRecord
end
```

Controllers não são limitados às actions REST. Qualquer método público pode ser uma action.

```ruby
# Controller
class UsersController < ApplicationController
  def activate
    # lógica personalizada
  end
end

# Rota correspondente
post "users/:id/activate", to: "users#activate"
```

## Rotas

> config/routes.rb

Arquivo que determina as rotas (e verbos) da aplicação. A URL "<host>/rails/info/routes" mostra todas as rotas disponíveis no aplicativo.

```ruby
# [get | post | put | patch | delete | options] "nome_da_rota" => "controller#action"
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

- link_to: Substitui o "href" do elemento \_anchor\*
- [Lista completa](https://guides.rubyonrails.org/action_view_helpers.html)

```ruby
# View - link_to(name, path)
<%= link_to "Texto", :action => "action_name" %>

# <%= link_to "Texto", "/customers" %> >> 'customers_path' é gerado automaticamente pelo Rails (/rails/info/routes)
<%= link_to "Texto", customers_path %>

# Adiciona o método HTTP e gera um alerta de confirmação
<%= link_to "Texto", @customer, method: :delete, data: { confirm: "Are you sure?" } %>
```

#### Criando helper

Os _helpers_ encontram-se na pasta _/app/helpers_. Cada model tem seu helper e o helper criado dentro de "application_helper.rb" será um helper global. O método criado pode ser chamado na view especificada ou em todas (caso tenha sido criado em "application_helper").

## Active Record

Active Record é uma gem presente no Ruby on Rails e é responsável por tratar a persistência das informações no Banco de Dados.

> NOTA: Para visualizar os campos do modelo, veja os arquivos de migrate.

Active Record permite o desenvolvedor crie DBs sem necessitar de SQL, pois, utiliza DSL (Doman Specif Language)

> Active Record também é um padrão de projeto para Banco de Dados relacionais. **É onde ocorre as validações**.

```ruby
# Operações CRUD
# Create
model = <Model>.create(name: "John Doe", age: 20) # Cria o objeto no Banco de Dados e retorna a instância do modelo criado
model = <Model>.new(name: "John Doe", age: 20) # Instância o objeto e depois salva no banco de dados
model.save

# Read
<Model>.all           # Retorna um array com *todos* os registros
<Model>.find_each     # Retorna um batch de 1000 elementos (padrão)
<Model>.ids           # Retorna um array contendo todos os ids
<Model>.first         # Retorna o primeiro elemento
<Model>.last          # Retorna o último elemento
<Model>.find(1)       # Busca por id. Aceita múltiplos argumentos
<Model>.find_by(name: "John")   # Busca por atributo. Retorna o primeiro elemento encontrado
<Model>.where(name: :John)      # Busca por atributo. Retorna um array

# Método "where" com "like"
<Model>.where("name like '%#{params[:name]}%'")     # ERRO: Perigo de SQL Injection
<Model>.where("name like ?", "%#{params[:name]}%")  # Correto

# TODO: Pesquisar escopos (Scopes)

# DICA: Modifique o Model para ter um método where_like
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

## Upload de arquivos

> gem Paperclip

## Devise (Auth)

Devise é construída sobre Warden, uma biblioteca de autenticação de baixo nível, e integra-se de forma nativa ao ActiveRecord, gerando controllers, views e validações prontas, alinhadas às boas práticas do Rails.

Fornece funcionalidades como login, logout, registro, recuperação de senha, confirmação de conta, bloqueio por tentativas, sessão persistente (remember me) e expiração de sessão. O comportamento é modular, permitindo ativar apenas os recursos necessários.

Links úteis:

- [Repositório](https://github.com/heartcombo/devise)
- [How-Tos](https://github.com/heartcombo/devise/wiki/How-Tos)

```shell
# Adicionando Devise no Gemfile
bundle add devise

# Instalando Devise
rails g devise:install

# Gerando modelo Devise
# "User" é uma convenção e não uma regra, poderia, por exemplo, ser "Admin". Pode haver mais de um modelo, como User e Admin e não apenas um ou outro
rails g devise User
rails g devise User role:integer    # Atributos adicionais

# Gerando views e controllers
rails g devise:views
rails g devise:controllers
```

### Roles

O Devise gera o mesmo *form* para todos os modelos, caso seu app tenha mais de um modelo (role), utilize a configuração abaixo para gerar as views individualmente.

```ruby
# config/initializers/devise.rb
config.scoped_views = true

# CLI
rails g devise:views users          # Gera view específica
rails g devise:controllers [scope]  # Scope é o modelo Devise, ex.: User, Admin, etc.
```

> NOTA: Utilize a gem **Pundit** para definir lógica de *roles* (Policy object pattern).

Request > Devise > Controller > Pundit > Action

### Controller filters and helpers

> Se o modelo gerado pelo Devise for diferente de User, troque "_user" por "_meumodelo".

```ruby
# Redireciona caso o usuário não esteja autenticado
before_action :authenticate_user!

# Verifica se o usuário está autenticado
user_signed_in?

# Retorna o usuário atual
current_user.email

# Retorna a sessão atual
user_session
```

## Ransack

> Pesquisa no Banco de Dados como "ElasticSearch"

[Guia da gem](https://github.com/activerecord-hackery/ransack)

## Logs

> TODO

## Testes

Principais tipos de testes:

- **Teste Unitário**: É toda a aplicação de teste na assinaturas de entrada e saída de um sistema. Consiste em validar dados válidos e inválidos via I/O. Uma unidade é a menor parte testável de um programa de computador. **Testa métodos** na prática.
- **Teste de Integração**: É a fase do teste de software em que módulos são combinados e testados em grupo. Ela sucede o teste de unidade, em que os módulos são testados individualmente, e antecede o teste de sistema, em que o sistema completo (integrado) é testado num ambiente que simula o ambiente de produção. **É quando temos mais de um teste de unidade testado ao mesmo tempo**.
- **Teste de Aceitação**: É uma fase do processo de teste em que um teste de caixa-preta é realizado num sistema antes de sua disponibilização. Tem por função verificar o sistema em relação aos seus requisitos originais, e às necessidades atuais do usuário. **Testa se o sistema atende aos requisitos**, valida as ações do usuário como clicar e preencher campos.

A gem _RSpec(-Rails)_ (pasta _spec_) é utilizada para Testes Unitários e de Integração, já para Testes de Aceitação, é utilizado a gem _Capybara_. Por padrão o Rails utiliza a biblioteca MiniTest (pasta padrão _test_).

### TDD (Test Driven Development)

É uma metodologia de desenvolvimento de software que visa criar software de maior qualidade e confiabilidade.

Como funciona o TDD?

- O desenvolvedor escreve um teste que representa o que o código deve fazer
- O desenvolvedor cria o código para passar nesse teste
- O código é alterado iterativamente até que os testes sejam bem-sucedidos

![TDD](/assets/images/tdd.png)

## Framework front-end

### Adicionando assets de terceiros

Utilize o **content_for :head do** dentro da view que deseja adicionar o asset. Para JavaScript utilize a tag _javascript\_include\_tag 'nome\_do\_asset'_ e para CSS utilize _stylesheet\_link\_tag 'nome\_do\_asset'_.

> Lembre-se que é preciso carregar o asset em: config/initializers/assets.rb

Locais onde é recomendado colocar os arquivos tipo assets (Organização):

- app/assets: Local onde fica os assets gerados **automaticamente**
- lib/assets: Assets **criados** pelo desenvolvedor
- vendor/assets: Assets de **terceiros** como plugins

### Twitter Bootstrap

Framework web front-end para desenvolver aplicativos responsivos. Acesse [aqui](https://getbootstrap.com/2.0.2/).

### Rails Composer

App terceiro que gera template de views.

## Asset Pipeline

Provê um framework para concatenar (unificar) e minificar (comprimir) recursos como JavaScript e CSS. Também permite escrever esses formatos a partir de pré-processadores como CoffeeScript, Sass e ERB.

> Gem padrão: Sprockets. OBS: Requer um runtime JS em ruby como ExecJS.

Fingerprint (impressão digital) é a técnica que "força" o navegador a fazer o download dos _assets_ afim de sobreescrever o cache. Esta técnica é realizada modificando o nome dos assets e quando o navegador identifica um novo nome para o recurso, ele realiza o download - é uma ação realizada automaticamente quando os assets são compilados.

Locais onde é recomendado colocar os arquivos tipo assets (Organização):

- app/assets: Local onde fica os assets gerados **automaticamente**
- lib/assets: Assets **criados** pelo desenvolvedor
- vendor/assets: Assets de **terceiros** como plugins

### Assets personalizados

Para apontar quais assets devem ser pré-compilados, modifique o seguinte arquivo:

```ruby
# config/initializers/assets.rb
Rails.application.config.assets.precompile += %w( nome_do_asset.[js | coffee | sass | css] )
```

Para utilizar o asset compilado, modifique o seguinte arquivo:

```html
<!-- app/views/layouts/application.html.erb -->
<%= stylesheet_link_tag 'nome_do_asset' %> <%= javascript_include_tag
'nome_do_asset' %>

<!-- params[:controller] retorna a página atual (url) -->
<!-- Faz com que cada página tenha seu assets -->
<%= javascript_include_tag params[:controller] %>
```

## Ajax

Função JavaScript que permite realizar requisições assincronas sem que a página seja recarregada.

> Ciclo Ruby on Rails (RoR): Browser > Controller > JavaScript > Browser

```ruby
# OBS: Resposta no formato HTML e Json serão ignoradas neste exemplo. "format.js" será o hook para solicitações tipo JS.

# app/controllers/meu_controller.rb
def create
  @user = User.new(user_params)

  respond_to do |format|
    if @user.save # Sucesso
      format.js   # retorna o arquivo: app/views/minha_view/create.js.erb
    else          # Erro
      format.js
    end
  end
end
```

```html
<!-- Adicione "remote: true" no helper "form_for" para relizar chamadas ajax -->

<!-- app/views/minha_view/create.html.erb -->
<%= form_for(@user, remote: true) do |f| %> <%# ... %> <% end %>
```

## Painel Administrativo (activeadmin)

> gem: activeadmin [link](https://github.com/activeadmin/activeadmin)
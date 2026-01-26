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

Requer que a join table seja criada através duma migration. O nome da tabela deve ser o nome dos dois modelos pluralizado e em ordem alfabética, e sem _primary key_.

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
- before\_[create | update | destroy]
- around\_[create | update | destroy]
- after\_[create | update | destroy]
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

O Devise gera o mesmo _form_ para todos os modelos, caso seu app tenha mais de um modelo (role), utilize a configuração abaixo para gerar as views individualmente.

```ruby
# config/initializers/devise.rb
config.scoped_views = true

# CLI
rails g devise:views users          # Gera view específica
rails g devise:controllers [scope]  # Scope é o modelo Devise, ex.: User, Admin, etc.
```

> NOTA: Utilize a gem **Pundit** para definir lógica de _roles_ (Policy object pattern).

Request > Devise > Controller > Pundit > Action

### Controller filters and helpers

> Se o modelo gerado pelo Devise for diferente de User, troque "\_user" por "\_meumodelo".

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

### Pundit

Biblioteca de autorização que utiliza classes Ruby simples (chamadas de Policies) para decidir se um usuário tem permissão para realizar uma ação específica em um objeto. Diferente de outras ferramentas, ele foca em ser mínimo e explícito, usando apenas orientação a objetos básica.

Aplicação:

- `bundle add pundit`
- `rails g pundit:install`
- Incluir `Pundit::Authorization` no `ApplicationController`
- `rails g pundit:policy <model_name>`

#### Authorize

Sua função é responder a uma pergunta simples: "Este usuário tem permissão para fazer isso com este objeto?", se a resposta for "sim" (o método na Policy retornar `true`), o código segue normalmente. Se for "não" (`false` ou `nil`), o Pundit interrompe a execução e levanta a exceção `Pundit::NotAuthorizedError`.

Assume automaticamente que um modelo `User` possui uma classe `UserPolicy` correspondente. Em seguida, instancia a policy com o usuário atual e o objeto User específico. Ele utiliza o nome da ação (por exemplo, `create`) para chamar o método apropriado da policy (`create?`).

> TODO: `user` é fornecido pelo current_user (Devise)

```ruby
# app/policies/post_policy.rb
class PostPolicy < ApplicationPolicy
  def edit?
    user.admin?   # Saída: true ou false
  end

  def update?
    user.admin?
  end
end

# app/controllers/posts_controller.rb
# Uso Padrão (Inferência)
def edit
  authorize @post # Pundit deduz que deve chamar 'edit?' na PostPolicy
end

# Uso Explícito (Quando a ação tem nome diferente)
def publicar
  @post = Post.find(params[:id])
  authorize @post, :update? # Força o Pundit a usar o método 'update?' em vez de 'publicar?'
end

# Uso sem Registro (Classes)
def new
  authorize Post # Procura por 'new?' na PostPolicy
  @post = Post.new
end
```

#### Scope

O Scope é uma ferramenta para filtrar coleções de dados (**listas**) com base nas permissões do usuário.

Enquanto o `authorize` serve para verificar se um usuário pode realizar uma ação em um único registro (ex: "Eu posso editar este post?"), o Scope serve para definir quais registros o usuário pode ver em uma listagem (ex: "Quais posts eu tenho permissão para listar?").

Dentro da sua `PostPolicy`, por exemplo, existe uma classe interna chamada `Scope`. Nela, você define o método `resolve`.

> É comumente utilizado para a action `index`, porém, há outros casos de uso como retornar uma lista para um _dropdown_, entre outros.

```ruby
# app/policies/post_policy.rb
class Scope < ApplicationPolicy::Scope
  # O scope dentro do método resolve refere-se à classe que você passou (neste caso, Post)
  def resolve
    if user.present? && user&.admin?
      scope.all
    else
      scope.where(published: true)
    end
  end
end

# app/controllers/post_controller.rb
def index
  @posts = policy_scope(Post)

  # Você pode usar o Scope inclusive para associações
  @posts = policy_scope(@user.posts) # Aplica o filtro nos posts deste usuário específico
end
```

#### Permitted Attributes

Centraliza quem pode editar o quê diretamente na Policy, usando o método `permitted_attributes`. Por exemplo, o usuário comum pode atualizar apenas o conteúdo do post enquanto o admin pode modificar o título e o conteúdo.

E se o usuário puder definir o status ao criar um post, mas não puder editá-lo depois? O Pundit é inteligente o suficiente para buscar `permitted_attributes_for_#{action}` automaticamente.

```ruby
# app/policies/post_policy.rb

# def permitted_attributes_for_create
# def permitted_attributes_for_update
def permitted_attributes
  if user.admin?
    [ :title, :body ]
  else
    [ :body ]
  end
end

# app/controllers/posts_controller.rb
  def update
    authorize @post

    respond_to do |format|
      # Troque "post_params" por "permitted_attributes(@post)"
      if @post.update(permitted_attributes @post)
        format.html { redirect_to @post, notice: "Post was successfully updated.", status: :see_other }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end
```

#### Validação vs. Autorização

É importante separar as responsabilidades:

- Model (Validação): Foca no O QUÊ. "Este post pode existir?" (Ex: Tem título? O conteúdo é curto demais?). A regra vale para todos, independente de quem está salvando.
- Pundit/Policy (Autorização): Foca no QUEM. "Este usuário específico tem permissão para fazer isso agora?".

#### Views

Você pode acessar uma instância da policy tanto nas views quanto nos controllers usando o método policy. Esse recurso é muito valioso para exibir links ou botões de forma condicional na view.

```erb
<% if policy(@user).update? %>
  <%= link_to "Edit User", edit_user_path(@user) %>
<% end %>
```

#### Helpers e mensagem de erro customizada

```ruby
# app/controllers/application_controller.rb
class ApplicationController < ActionController::Base
  include Pundit

# Mensagem de erro customizada
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  # Lança uma exeção caso não tenha configurado um `authorize` na action (Funciona como um "lembrete")
  after_action :verify_authorized
  # Similar ao utilitário acima, porém, monitora o `policy_scope` no lugar do `authorize`
  after_action :verify_policy_scoped, only: :index

  private

  def user_not_authorized(exception)
    # The default behavior uses the I18n lookup
    flash[:alert] = t("#{policy_scope_key(exception.policy)}", scope: "pundit", default: :default)
    redirect_to(request.referrer || root_path)
  end

  # Helper method to get the correct I18n key for the policy
  def policy_scope_key(policy)
    "#{policy.class.to_s.underscore}.#{exception.query}"
  end
end
```

## Hotwire

Hotwire significa **HTML Over The Wire**. A ideia central é enviar HTML pronto do servidor para o cliente, em vez de enviar JSON e deixar o JavaScript reconstruir a página.

Caso de uso: Mudar de página sem recarregar ou atualizar uma lista de comentários.

### Turbo

É o principal mecanismo do Hotwire. Carrega os novos posts automaticamente via WebSocket sem você dar refresh.

Ele se divide em três partes:

- Turbo Drive: Acelera a navegação capturando cliques em links e submissões de formulários, substituindo apenas o <body> da página sem um "refresh" completo
- Turbo Frames: Permite dividir a página em blocos independentes. Ao clicar em algo dentro de um frame, apenas aquele pedaço da página é atualizado
- Turbo Streams: Permite fazer atualizações parciais na página (adicionar, remover ou trocar elementos) via WebSockets (ActionCable) ou em resposta a um formulário
- Turbo Native: Gere aplicativos nativos para iOS e Android através do seu monolito

[Saiba mais](https://turbo.hotwired.dev/handbook/introduction)

### Turbo Drive

Funciona interceptando cliques em links e submissões de formulários, buscando o HTML via AJAX e substituindo apenas o conteúdo do `<body>`, mantendo o `<head>` (e, consequentemente, o JavaScript e CSS) carregados.

> No Rails 7+, o Turbo Drive já vem **habilitado por padrão**.

Conceito:

- Captura o clique no link
- Busca a nova página em segundo plano
- Troca o corpo (`<body>`) atual pelo novo
- Sincroniza o `<head>` se houver mudanças

```erb
<%# Link normal - Turbo Drive intercepta automaticamente %>
<%= link_to "Ver Perfil", user_path(@user) %>

<%# Link que abre em uma nova aba - Turbo Drive ignora automaticamente %>
<%= link_to "Google", "https://google.com", target: "_blank" %>

<%# Desabilitando Turbo em link ou form %>
<%= link_to "Ver Perfil", user_path(@user), data: { turbo: false } %>
```

Submissão de formulário:

- Sucesso: O servidor deve responder com um redirecionamento (status 303)
- Erro: O servidor deve responder com um `:unprocessable_entity` (status 422) para que o Turbo Drive atualize a página com as informações de erro de validação (notice / alert)

#### Turbo Morphing

Permite atualizar a página sem que o scroll mude de posição ou que vídeos/inputs percam o foco.

O Turbo compara o HTML novo com o antigo e altera apenas o que mudou, como se fosse um "diff" do React, mas feito no servidor.

```erb
<%# app/views/layouts/application.html.erb %>
<head>
  <%# ... %>
  <%= turbo_refreshes_with method: :morph, scroll: :preserve %>
</head>
```

#### Prefetch

Quando o usuário passa o mouse sobre um link, o Turbo começa a baixar a página antes mesmo do clique ocorrer.

```erb
<%# app/views/layouts/application.html.erb %>
<head>
  <%# ... %>
  <meta name="turbo-prefetch" content="true">
</head>
```

### Turbo Frame

Permite que você divida sua página em "pedaços" independentes. Quando você clica em um link ou envia um formulário dentro de um Frame, apenas aquele pedaço é atualizado, sem afetar o resto da página.

Conceito:

- O usuário clica em um link dentro de um `<%= turbo_frame_tag "meu_bloco" do %>`
- O servidor responde com uma página HTML completa
- O Turbo ignora tudo da página nova, exceto o conteúdo que está dentro do `<%= turbo_frame_tag "meu_bloco" do %>`
- Ele substitui o conteúdo antigo pelo novo apenas naquele local

#### Self-Replacement (ou "Inline")

É quando um Turbo Frame substitui a si mesmo. É o comportamento padrão.

> Exemplo: Um botão "Editar" dentro de um card que transforma o card em um formulário.

```erb
<%# app/views/tasks/index.html.erb %>
<% @tasks.each do |task| %>
  <%# `dom_id()` evita conflitos de IDs no DOM %>
  <%= turbo_frame_tag dom_id(task) do %>
    <p><%= task.name %></p>
    <%= link_to "Editar Nome", edit_task_path(task) %>
  <% end %>
<% end %>

<%# app/views/tasks/edit.html.erb %>
<%# A página de edição deve ter um frame com o mesmo ID %>
<%= turbo_frame_tag dom_id(@task) do %>
  <%= form_with model: @task do |f| %>
    <%= f.text_field :name %>
    <%= f.submit "Salvar" %>

    <%# Saindo do Frame / Breakout ou Top-level Navigation %>
    <%= link_to "Cancelar", task_path(@task), data: { turbo_frame: "_top" } %>
  <% end %>
<% end %>

<%# Helper: Verifica se a requisição é Turbo %>
<% if turbo_frame_request? %>
  <%# Conteúdo... %>
<% end %>
```

#### Targeting a Frame (ou "Targeted Update")

Utiliza usa o atributo `data-turbo-frame` para apontar para um ID de um frame que está em outro lugar da página.

> Exemplo: Uma barra lateral com uma lista de contatos. Ao clicar em um contato, o frame central (o perfil) é atualizado.

```erb
<%= link_to "Filtrar categoria", posts_path(cat: "tech"), data: { turbo_frame: "lista_de_posts" } %>

<%= turbo_frame_tag "lista_de_posts" do %>
  <%# Conteúdo será inserido aqui %>
<% end %>
```

#### Lazy Loading

Quando o frame não carrega com a página, mas faz uma requisição automática para o `src` assim que aparece na tela.

> Dica UI/UX: Utilize _Skeletons_ para elementos que estão em "loading".

```erb
<%# app/views/dashboards/show.html.erb %>
<h1>Meu Dashboard</h1>

<%= turbo_frame_tag "estatisticas_vendas", src: statistics_path, loading: "lazy" do %>
  <p>Conteúdo que será substituído</p>
<% end %>
```

### Turbo Streams

[Helpers](https://github.com/hotwired/turbo-rails?tab=readme-ov-file#rubydoc-documentation)

O Turbo Streams permite que o servidor envie instruções para alterar múltiplas partes da página de uma só vez. Ele pode adicionar, remover ou atualizar elementos em resposta a um formulário ou via WebSockets (em tempo real).

O Rails procura por um arquivo Turbo Stream chamado `*.turbo_stream.erb` quando a requisição vem de um formulário Turbo. Observe que "\*" é o nome da ação, por exemplo, create, update ou destroy.

Lista de ações Turbo Stream:

- `append`: Adiciona ao final de um elemento
- `prepend`: Adiciona ao início de um elemento
- `replace`: Substitui o elemento inteiro
- `update`: Substitui apenas o conteúdo interno do elemento
- `remove`: Remove o elemento
- `before`: Insere antes do elemento
- `after`: Insere depois do elemento

#### Formulário

```ruby
# Controller
def create
  # ...
  respond_to do |format|
    format.turbo_stream # Procura por create.turbo_stream.erb
    format.html { redirect_to @comment }
  end
end
```

```erb
<%# View %>
<%# turbo_stream.<action> "target_id", partial: "content_view", locals: { content_data } %>

<%# app/views/comments/create.turbo_stream.erb %>
<%# Adiciona o novo comentário ao início da lista com ID "comments_list" %>
<%= turbo_stream.prepend "comments_list", partial: "comments/comment", locals: { comment: @comment } %>

<%# Limpa o formulário de comentário após o envio %>
<%= turbo_stream.replace "new_comment_form", partial: "comments/form", locals: { comment: Comment.new } %>

<%# app/views/comments/destroy.turbo_stream.erb %>
<%# Remove o elemento que tem o ID dom_id(@comment), ex: "comment_42" %>
<%= turbo_stream.remove @comment %>
```

#### WebSocket (Broadcast)

Pode fazer com que um comentário, por exemplo, apareça na view de todos os usuários no momento em que ele é criado, atualizado ou removido; utiliza `ActionCable` (WebSockets).

> Nota: Utilize `<%= console %>` em alguma view para acionar o Turbo Broadcast no lugar de `bin/dev` ou `rails server`.

```ruby
# app/models/comment.rb
class Post < ApplicationRecord
  # Por padrão cria um canal chamado "posts"
  broadcasts
end

# app/models/comment.rb
class Comment < ApplicationRecord
  belongs_to :post

  # Transmite automaticamente para quem estiver "ouvindo" o post deste comentário
  # Substitui as seguintes declarações. Adicione `broadcasts` no modelo Post
  # broadcasts_to :post
  after_create_commit -> { broadcast_prepend_to [post, :comments], target: "comments_list" }
  after_update_commit -> { broadcast_remove_to [post, :comments] }
  after_destroy_commit -> { broadcast_remove_to [post, :comments] }
end
```

```erb
<%# app/views/posts/show.html.erb %>
<%# Abre o canal de comunicação em tempo real. O argumento deve ser uma string válida %>
<%= turbo_stream_from [@post, :comments] %>

<div id="comments_list">
  <%= render @post.comments %>
</div>
```

## Stimulus

O Stimulus.js é um framework JavaScript modesto e focado em HTML, criado pela mesma equipe do Ruby on Rails (37signals).

O Hotwire é uma "suíte" ou um guarda-chuva de tecnologias, enquanto o Stimulus é uma ferramenta específica dentro desse pacote. Trabalha localmente no navegador (Manipulação de DOM/Eventos).

Possuí três conceitos principais aplicados diretamente ao HTML:

- Controllers: Onde o código JavaScript reside
- Targets: Elementos específicos que serão manipulados
- Values: Armazena estados no `data-controller`
- Actions: Eventos (como cliques) que disparam funções no controller

### Controller

É uma classe JavaScript que define a lógica de um componente. Ele é conectado ao HTML através do atributo `data-controller="nome"`. Toda vez que esse atributo aparece no DOM, o Stimulus cria uma nova instância dessa classe.

O nome do arquivo do controller determina o seu identificador no DOM. Por exemplo, o `hello_controller.js` terá como identificador `hello`.

#### Associando controlador-elemento

```javascript
// app/javascript/controllers/hello_controller.js

import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  // Ciclo de vida (Opcional)
  initialize() {
    // Executado quando o controlador é iniciado
  }

  connect() {
    // Executado quando o controlador conecta ao DOM
  }

  disconnect() {
    // Executado quando o controlador desconecta ao DOM
  }

  // Personalizado
  my_method() {
    // Executado através de algum evento, inclusive do lifecycle
  }
}
```

```erb
<%# View %>

<div data-controller="hello">
    <p>Hello, world!</p>
</div>
```

### Targets

São as referências aos elementos HTML importantes dentro do seu controller. Em vez de usar `document.getElementById()`, você marca elementos com `data-controller-target="alvo"` e o Stimulus os disponibiliza automaticamente no JavaScript como `this.alvoTarget`.

#### Lendo e modificando dados

```javascript
// app/javascript/controllers/hello_controller.js

import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  // Busca por 'data-hello-target="message"'
  static targets = ["message"];

  // Acionado pelo evento de "click"
  greet(event) {
    event.preventDefault();
    this.messageTarget.textContent = "Hello, world!";

    // this.[attr-key]Target   # Retorna o elemento apontado pelo target
    // this.messageTargets     # Retorna um array dos "message" targets encontrados
    // this.hasMessageTarget   # Retorna true ou false
    // this.element            # Retorna o elemento HTML e todos as suas propriedades e métodos
  }
}
```

```erb
<%# View %>

<div data-controller="hello">
    <!-- data-[identifier]-target="[attr-key]" -->
    <p data-hello-target="message"></p>

    <!-- data-action="[event]->[controller]#[method]" -->
    <button data-action="click->hello#greet">Greetings</button>
</div>
```

### Values

São as variáveis de estado ou configurações que você passa do HTML para o JavaScript. Através de atributos como `data-controller-nome-value="10"`, você consegue ler, escrever e até observar mudanças nesses dados diretamente no controller.

Características:

- Controllers são stateless
- Estados são armazenados no DOM através de datasets

```javascript
// app/javascript/controllers/hello_controller.js

import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  // static values = { counter: Number }
  static values = { counter: { type: Number, default: 0 } };
  static targets = ["counter"];

  decrement() {
    this.counterValue--;
  }

  increment() {
    this.counterValue++;
  }

  // Acionado quando o valor de "counter" é modificado
  // [value-key]ValueChanged
  counterValueChanged() {
    // this.[attr-key]Target.* = this.[value-key]Value
    this.counterTarget.textContent = this.counterValue;
  }
}
```

```erb
<%# View %>
<%# Um novo atributo será adicionado no `data-controller`: data-hello-counter-value="0" %>

<div data-controller="hello">
  <button data-action="click->hello#decrement">-</button>
  <p data-hello-target="counter"></p>
  <button data-action="click->hello#increment">+</button>
</div>
```

### External content

[Guia](https://stimulus.hotwired.dev/handbook/working-with-external-resources)

## Logs

> TODO

## Testes

Principais tipos de testes:

- **Teste Unitário**: É toda a aplicação de teste na assinaturas de entrada e saída de um sistema. Consiste em validar dados válidos e inválidos via I/O. Uma unidade é a menor parte testável de um programa de computador. **Testa métodos** na prática.
- **Teste de Integração**: É a fase do teste de software em que módulos são combinados e testados em grupo. Ela sucede o teste de unidade, em que os módulos são testados individualmente, e antecede o teste de sistema, em que o sistema completo (integrado) é testado num ambiente que simula o ambiente de produção. **É quando temos mais de um teste de unidade testado ao mesmo tempo**.
- **Teste de Aceitação**: É uma fase do processo de teste em que um teste de caixa-preta é realizado num sistema antes de sua disponibilização. Tem por função verificar o sistema em relação aos seus requisitos originais, e às necessidades atuais do usuário. **Testa se o sistema atende aos requisitos**, valida as ações do usuário como clicar e preencher campos.

A gem _RSpec(-Rails)_ (pasta _spec_) é utilizada para Testes Unitários e de Integração, já para Testes de Aceitação, é utilizado a gem _Capybara_. Por padrão o Rails utiliza a biblioteca MiniTest (pasta padrão _test_), para deixar de gerar testes _minitest_ utilize a flag `-T` ao gerar o projeto Rails ou remova a pasta `test` em um projeto já existente.

### RSpec

O RSpec é um framework de testes orientado a **Behavior-Driven Development (BDD)** para Ruby que oferece uma alternativa ao framework padrão utilizado pelo Rails (Minitest).

BDD é um processo colaborativo que define o comportamento do sistema por meio de exemplos em linguagem natural, alinhando stakeholders, desenvolvedores e testadores, e expressando requisitos de forma clara no formato **Given–When–Then**, o que reduz ambiguidades e previne defeitos.

O RSpec utiliza palavras-chave como `describe`, `context` e `it` para estruturar os testes como especificações de comportamento - Arrange, Act e Assert -, tornando-os altamente legíveis, expressivos e fáceis de manter.

[Documentação](https://rspec.info/documentation/)

#### Instalação, geração e execução

```shell
# Adicionar no Gemfile
bundle add rspec-rails -g 'development, test'

# Instalação
rails generate rspec:install

# Gerando teste boilerplate
rails generate rspec:model user

# Verifica outros comandos geradores
rails generate --help | grep rspec

# Execução
rspec                 # Todos
rspec spec/models     # Pasta
rspec spec/controllers/accounts_controller_spec.rb      # Arquivo
rspec spec/controllers/accounts_controller_spec.rb:42   # Arquivo:Linha
```

> Opcional: Adicione `--format documentation` no arquivo _.rspec_ gerado para alterar o output dos testes.

#### Matchers

Matchers são as expressões que definem o que você está testando. Eles são as "regras de comparação".

No RSpec, enquanto o `expect` identifica o objeto, o matcher é quem faz a pergunta: "Este objeto é igual a X?", "Ele contém Y?" ou "Ele lançou o erro Z?".

| Matcher                       | Descrição                                                                                    | Exemplo                                                        |
| ----------------------------- | -------------------------------------------------------------------------------------------- | -------------------------------------------------------------- |
| `eq(expected)`                | Verifica igualdade de valor usando `==`                                                      | `expect(5).to eq(5)`                                           |
| `eql(expected)`               | Verifica igualdade de objetos usando `eql?`                                                  | `expect([1, 2]).to eql([1, 2])`                                |
| `equal(expected)`             | Verifica identidade de objeto usando `equal?` (mesmo objeto na memória)                      | `expect(obj1).to equal(obj1)`                                  |
| `be(expected)`                | Matcher flexível, frequentemente usado para verificar _truthiness_ ou identidade             | `expect(true).to be(true)`                                     |
| `be_truthy`, `be_falsey`      | Verifica se um valor é _truthy_ (não é `false` nem `nil`) ou _falsey_ (`false` ou `nil`)     | `expect("hello").to be_truthy`                                 |
| `be_nil`                      | Verifica se um valor é `nil`                                                                 | `expect(variable).to be_nil`                                   |
| `be_instance_of(klass)`       | Verifica se um objeto é uma instância exata de uma classe específica                         | `expect("string").to be_instance_of(String)`                   |
| `be_kind_of(klass)`           | Verifica se um objeto é de um determinado tipo de classe ou módulo (inclui herança)          | `expect("string").to be_kind_of(Object)`                       |
| `match(/regex/)`              | Verifica se uma string ou objeto corresponde a uma expressão regular ou valor especificado   | `expect("RSpec").to match(/RSpec/)`                            |
| `include(item1, item2, ...)`  | Verifica se uma coleção inclui os itens especificados                                        | `expect([1, 2, 3]).to include(2)`                              |
| `contain_exactly(item1, ...)` | Verifica se uma coleção contém exatamente os itens especificados, independentemente da ordem | `expect([1, 2]).to contain_exactly(2, 1)`                      |
| `raise_error(ErrorClass)`     | Usado com um bloco para verificar se o código lança (`raise`) um erro específico             | `expect { raise StandardError }.to raise_error(StandardError)` |
| `change { ... }`              | Usado com um bloco para verificar se um valor muda após a execução do código                 | `expect { counter += 1 }.to change { counter }.by(1)`          |

```ruby
# Arrange
RSpec.describe "Calculator" do
  context "add" do
    it "returns the sum of two numbers" do
      # Act
      result = Calculator.add(7, 5)

      # Assert [.to | .not_to]
      expect(result).to eq(12)
    end
  end
end

RSpec.describe Post do
  context "before publication" do
    it "cannot have comments" do
      post = Post.create

      # NOTA: Usamos { } em vez de ( ) para executar ações e capturar exceções.
      expect {
        post.comments.create! body: "Hello, world!"
      }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end
end
```

### GitHub Actions

> TODO

## Dicas

- [Simple CSS](https://github.com/kevquirk/simple.css/wiki/Getting-Started-With-Simple.css): Estilização sem customização inicial

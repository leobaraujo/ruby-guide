# Ruby on Rails

Ruby on Rails é um framework web de alto nível escrito em Ruby, criado em 2004 por David Heinemeier Hansson (DHH) a partir do desenvolvimento do Basecamp.

Rails se baseia fortemente nos princípios de **CoC** (Convention over Configuration) e **DRY** (Don’t Repeat Yourself), incentivando código limpo, reutilizável e fácil de manter. O framework segue a **arquitetura MVC**, e oferece um ecossistema completo com ferramentas integradas como o **ActiveRecord** para acesso ao banco de dados, um sistema de rotas expressivo e suporte nativo a testes.

[Documentação](https://rubyonrails.org/docs)

## Table of Contents

- [Ruby on Rails](#ruby-on-rails)
  - [Table of Contents](#table-of-contents)
  - [Características](#características)
    - [Convention over Configuration (CoC)](#convention-over-configuration-coc)
    - [Estrutura de pastas](#estrutura-de-pastas)
  - [Comandos](#comandos)
  - [Models](#models)
    - [Validações](#validações)
    - [Associações](#associações)
      - [has\_and\_belongs\_to\_many](#has_and_belongs_to_many)
      - [Through](#through)
      - [Polymorphic association](#polymorphic-association)
    - [Callbacks](#callbacks)
      - [Service Object](#service-object)
    - [UUID](#uuid)
      - [Converter projeto existente](#converter-projeto-existente)
    - [Enum](#enum)
    - [Scopes](#scopes)
    - [Active Record Encryption (Rails 7+)](#active-record-encryption-rails-7)
  - [Controllers](#controllers)
    - [Actions](#actions)
    - [Helpers](#helpers)
  - [Views](#views)
    - [Embedded Ruby](#embedded-ruby)
    - [Partials](#partials)
    - [Formulário](#formulário)
      - [Helpers](#helpers-1)
      - [Formulários complexos e Nested Attributes](#formulários-complexos-e-nested-attributes)
    - [yield](#yield)
    - [Helpers](#helpers-2)
  - [Scaffold](#scaffold)
  - [Rotas](#rotas)
    - [Recuperando parâmetros](#recuperando-parâmetros)
    - [REST / RESTful](#rest--restful)
  - [Active Record](#active-record)
  - [Migration](#migration)
    - [Adicionando / removendo campos](#adicionando--removendo-campos)
    - [Aplicando migrações pendentes](#aplicando-migrações-pendentes)
    - [Operações em tabelas](#operações-em-tabelas)
  - [Solid Cache (Rails 8+)](#solid-cache-rails-8)
  - [Devise (Auth)](#devise-auth)
    - [Roles](#roles)
    - [Controller filters and helpers](#controller-filters-and-helpers)
    - [Pundit](#pundit)
      - [Authorize](#authorize)
      - [Scope](#scope)
      - [Permitted Attributes](#permitted-attributes)
      - [Validação vs. Autorização](#validação-vs-autorização)
      - [Views](#views-1)
      - [Helpers e mensagem de erro customizada](#helpers-e-mensagem-de-erro-customizada)
  - [Hotwire](#hotwire)
    - [Turbo](#turbo)
    - [Turbo Drive](#turbo-drive)
      - [Turbo Morphing](#turbo-morphing)
      - [Prefetch](#prefetch)
    - [Turbo Frame](#turbo-frame)
      - [Self-Replacement (ou "Inline")](#self-replacement-ou-inline)
      - [Targeting a Frame (ou "Targeted Update")](#targeting-a-frame-ou-targeted-update)
      - [Lazy Loading](#lazy-loading)
    - [Turbo Streams](#turbo-streams)
      - [Formulário](#formulário-1)
      - [WebSocket (Broadcast)](#websocket-broadcast)
  - [Stimulus](#stimulus)
    - [Controller](#controller)
      - [Associando controlador-elemento](#associando-controlador-elemento)
    - [Targets](#targets)
      - [Lendo e modificando dados](#lendo-e-modificando-dados)
    - [Values](#values)
    - [External content](#external-content)
  - [i18n (Internationalization)](#i18n-internationalization)
  - [Testes](#testes)
    - [RSpec](#rspec)
      - [Estrutura de pastas](#estrutura-de-pastas-1)
      - [Instalação, geração e execução](#instalação-geração-e-execução)
      - [Matchers](#matchers)
      - [Requisições (Devise)](#requisições-devise)
    - [GitHub Actions (CI/CD)](#github-actions-cicd)
  - [Deploy](#deploy)
  - [Rake Task](#rake-task)
  - [Cron Jobs](#cron-jobs)
    - [Sidekiq](#sidekiq)
  - [Dicas](#dicas)

## Características

### Convention over Configuration (CoC)

Convention over Configuration (CoC) é um dos princípios estruturantes do Ruby on Rails. A ideia central é reduzir decisões repetitivas assumindo convenções padronizadas. Se você segue essas convenções, o framework “adivinha” corretamente como sua aplicação deve funcionar — eliminando configuração explícita. Complementa o princípio DRY (Don't Repeat Yourself).

Se você seguir os padrões esperados, o framework funciona sem configuração adicional.

> Você configura apenas o que é **excepcional**.

Rails presume padrões para:

- Estrutura de diretórios
- Nomeação de classes
- Nomeação de tabelas
- Relacionamento entre camadas (MVC)
- Carregamento automático de constantes (Zeitwerk)

Impacto:

- Estrutura MVC rígida
- REST como padrão
- Naming consistente
- Estrutura opinativa

### Estrutura de pastas

> Arquitetura MVC

```
.
├── app/
│   ├── assets/              # Assets da aplicação (imagens, estilos, JS via importmaps ou bundlers)
│   ├── channels/            # WebSockets (Action Cable)
│   ├── components/          # ViewComponents (se utilizado)
│   ├── controllers/         # Controllers
│   ├── helpers/             # Helpers de views
│   ├── javascript/          # JavaScript moderno (importmap, esbuild, vite, etc.)
│   ├── jobs/                # Background jobs (Active Job)
│   ├── mailers/             # Mailers (Action Mailer)
│   ├── models/              # Models e regras de domínio (Active Record)
│   └── views/               # Views e templates
│
├── bin/                     # Scripts executáveis (rails, rake, setup, dev)
│
├── config/
│   ├── environments/        # Configurações por ambiente
│   ├── initializers/        # Inicialização de gems e configurações globais
│   ├── locales/             # I18n
│   ├── routes.rb            # Definição de rotas
│   ├── application.rb       # Configuração principal da aplicação
│   └── database.yml         # Configuração do banco de dados
│
├── db/
│   ├── migrate/             # Migrações do banco
│   ├── seeds.rb             # Dados iniciais
│   ├── schema.rb            # Schema do banco (ou structure.sql)
│   └── development.sqlite3  # Banco SQLite (quando utilizado)
│
├── lib/
│   ├── tasks/               # Rake tasks customizadas
│   └── modules/             # Código reutilizável / serviços / extensões
│
├── log/
│   ├── development.log
│   ├── test.log
│   └── production.log
│
├── public/
│   ├── assets/              # Assets pré-compilados
│   ├── favicon.ico
│   └── 404.html             # Páginas de erro estáticas
│
├── storage/                 # Active Storage (uploads locais)
│
├── test/                    # Testes automatizados (Minitest)
│   ├── controllers/
│   ├── models/
│   ├── system/
│   └── fixtures/
│
├── tmp/
│   ├── cache/               # Cache temporário
│   ├── pids/                # PID do servidor
│   └── sockets/             # Sockets
│
├── vendor/
│   └── assets/              # Assets externos não empacotados como gems
│
├── .gitignore
├── Gemfile                  # Dependências (Bundler)
├── Gemfile.lock
├── Rakefile
├── README.md
└── config.ru                # Rack configuration
```

## Comandos

| Comando                                            | Descrição                              | Observações / Variações                        |
| -------------------------------------------------- | -------------------------------------- | ---------------------------------------------- |
| `rails new <nome_do_projeto>`                      | Cria um novo projeto Rails             | SQLite por padrão                              |
| `rails new <nome_do_projeto> --database=ADAPTADOR` | Define o banco de dados                | `postgresql`, `mysql`, `sqlite3`               |
| `rails new <nome_do_projeto> --api`                | Cria uma aplicação Rails API-only      | Remove views e assets                          |
| `rails new <nome_do_projeto> --css tailwind`       | Cria app com Tailwind CSS              | Padrão Rails 7+                                |
| `rails server` ou `rails s`                        | Inicia o servidor Rails                | Porta padrão: 3000                             |
| `rails s -e <ambiente>`                            | Executa o servidor em outro ambiente   | `development`, `test`, `production`            |
| `rails console` ou `rails c`                       | Console interativo da aplicação        | Classes do app carregadas                      |
| `rails runner "<código>"`                          | Executa código Ruby no contexto do app | Ideal para scripts                             |
| `rails generate` ou `rails g`                      | Lista geradores disponíveis            |                                                |
| `rails generate <tipo> <nome>`                     | Gera código automaticamente            | `model`, `controller`, `migration`, `scaffold` |
| `rails destroy <tipo> <nome>`                      | Remove código gerado                   | Reverte `generate`                             |
| `rails routes`                                     | Lista todas as rotas                   | Use `-g` para filtrar                          |
| `rails db:create`                                  | Cria o banco de dados                  | Usa `database.yml`                             |
| `rails db:migrate`                                 | Executa migrations pendentes           |                                                |
| `rails db:rollback`                                | Desfaz a última migration              | `STEP=n`                                       |
| `rails db:reset`                                   | Recria o banco do zero                 | `drop + create + migrate + seed`               |
| `rails db:seed`                                    | Executa `db/seeds.rb`                  | Dados iniciais                                 |
| `rails db:prepare`                                 | Prepara banco automaticamente          | Muito usado em CI                              |
| `rails assets:precompile`                          | Compila assets para produção           | Deploy tradicional                             |
| `rails test`                                       | Executa testes (Minitest)              | Padrão Rails                                   |
| `rails about`                                      | Mostra infos do projeto                | Versões e ambiente                             |
| `rails app:update`                                 | Atualiza configs do Rails              | Importante em upgrades                         |
| `rails credentials:edit`                           | Edita credenciais criptografadas       | Por ambiente                                   |
| `rails tmp:clear`                                  | Limpa arquivos temporários             |                                                |
| `rails log:clear`                                  | Limpa logs                             |                                                |

> Nota: Adicione `RAILS_ENV=[production | development | test]` para modificar o ambiente de execução do comando.

## Models

O Model representa a camada de domínio e persistência. Nele ficam as regras de negócio, validações, associações e acesso ao banco de dados via ActiveRecord, que implementa o padrão ORM. O model não conhece HTTP nem renderização; seu foco é estado e comportamento do domínio.

```ruby
class Person < ApplicationRecord
  def hello
    "Hello!!"
  end
end
```

### Validações

Validações não substituem constraints do banco. Para integridade real, use índices únicos, NOT NULL e foreign keys no banco de dados.

| Validação   | Helper / Opção                        | Descrição                                     |
| ----------- | ------------------------------------- | --------------------------------------------- |
| Presença    | `validates :attr, presence: true`     | Garante que o atributo não seja nulo ou vazio |
| Ausência    | `validates :attr, absence: true`      | Garante que o atributo esteja vazio           |
| Unicidade   | `validates :attr, uniqueness: true`   | Garante valor único (requer índice no banco)  |
| Comprimento | `validates :attr, length: {}`         | Valida tamanho mínimo, máximo ou intervalo    |
| Formato     | `validates :attr, format: {}`         | Valida com expressão regular                  |
| Inclusão    | `validates :attr, inclusion: {}`      | Garante que o valor esteja em um conjunto     |
| Exclusão    | `validates :attr, exclusion: {}`      | Garante que o valor não esteja em um conjunto |
| Numérico    | `validates :attr, numericality: true` | Valida números e comparações                  |
| Confirmação | `validates :attr, confirmation: true` | Exige campo \*\_confirmation                  |
| Aceitação   | `validates :attr, acceptance: true`   | Valida aceite de termos                       |
| Comparação  | `validates :attr, comparison: {}`     | Compara valores (>=, <=, >, <)                |
| Associação  | `validates :assoc, presence: true`    | Garante associação presente                   |
| Customizada | `validate :method_name`               | Executa validação definida pelo desenvolvedor |

```ruby
attr_accessor :parent               # Cria um "atributo virtual" que pode ser utilizado na lógica de negócio, mas que não será persistido no banco de dados

validate :validate_age              # Define validações de atributos
validates :name, presence: true     # Executa validação customizada

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

Referências dentro de tabelas seguem a seguinte convenção: model-name_id. Lembre-se que o nome dos models são no **singular** (as tabelas ficarão no plural) e o "\_id" será adicionado automaticamente.

| Associação                | Tipo de Relação  | Descrição                                                                 |
| ------------------------- | ---------------- | ------------------------------------------------------------------------- |
| `has_one`                 | 1 → 1            | Relacionamento um para um                                                 |
| `has_many`                | 1 → N            | Relacionamento um para muitos                                             |
| `belongs_to`              | N → 1            | Pertence a outro modelo; **exige chave estrangeira (FK)**                 |
| `has_and_belongs_to_many` | N ↔ N            | N para N via tabela intermediária **sem model próprio**                   |
| `has_many :through`       | N ↔ N            | N para N via tabela intermediária **com model**, suporta atributos extras |
| `has_one :through`        | 1 → 1 (indireto) | Um para um indireto via outro modelo                                      |
| `dependent: :destroy`     | N → 1            | Define ação em cascata ao remover o pai                                   |

![Associação](/assets/images/Associacao.jpeg)

```shell
rails g model Father name:string
rails g model Child name:string father:references
```

```ruby
# Model
class Father < ApplicationRecord
  has_many :children    # Nome no plural
end

class Child < ApplicationRecord
  belongs_to :father    # Nome no singular
end

# Example
pai = Father.create(name: "John Doe")
filho = Child.create(name: "Junior Doe")

filho.father = pai  # Necessário para salvar o modelo
filho.save!

# ou

father.children.create(name: "Maria Doe")
```

#### has_and_belongs_to_many

É utilizado para estabelecer um relacionamento **muitos-para-muitos** entre dois modelos, sem a existência de um modelo intermediário. Esse relacionamento requer uma tabela de junção dedicada no banco de dados, que armazena apenas as chaves estrangeiras dos dois modelos associados e não possui chave primária própria, modelo correspondente nem atributos adicionais.

Requer que a join table seja criada através duma migration. O nome da tabela deve ser o nome dos dois modelos pluralizado e em ordem alfabética, e sem _primary key_.

> NOTA: Prefira `has_many :through`.

#### Through

Uma associação `[has_many | has_one] :through` é frequentemente usada para configurar um relacionamento muitos-para-muitos (ou um-para-um) com outro modelo/entidade.

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

| Callback            | Momento de Execução                                          |
| ------------------- | ------------------------------------------------------------ |
| `after_initialize`  | Após o objeto ser instanciado (`new` ou carregado do banco)  |
| `after_find`        | Após o objeto ser carregado do banco (`find`, `first`, etc.) |
| `before_validation` | Antes das validações                                         |
| `after_validation`  | Após as validações                                           |
| `before_save`       | Antes de salvar (create ou update)                           |
| `around_save`       | Envolve a operação de save                                   |
| `before_create`     | Antes de criar um novo registro                              |
| `around_create`     | Envolve a operação de create                                 |
| `after_create`      | Após criar o registro                                        |
| `before_update`     | Antes de atualizar um registro                               |
| `around_update`     | Envolve a operação de update                                 |
| `after_update`      | Após atualizar o registro                                    |
| `before_destroy`    | Antes de remover o registro                                  |
| `around_destroy`    | Envolve a operação de destroy                                |
| `after_destroy`     | Após remover o registro                                      |
| `after_save`        | Após salvar (create ou update)                               |
| `after_commit`      | Após commit bem-sucedido da transação                        |
| `after_rollback`    | Após rollback da transação                                   |
| `after_touch`       | Quando `touch` é chamado e `updated_at` é alterado           |

> NOTA: `after_save` é acionado mesmo que ocorra um erro. Para ações que devem ser acionadas apenas após o sucesso (como enviar e-mail), utilize `after_commit`.

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

### UUID

O [Active Record](#active-record) possui suporte integrado para o uso de `UUIDs` (Identificadores Únicos Universais) como chaves primárias ou como tipo de coluna, especialmente com o PostgreSQL.

Implementação:

```ruby
# 1. Habilitar extensão UUID no PostgreSQL (migration)
class EnableUuidExtension < ActiveRecord::Migration[7.1]
  def change
    # pgcrypto fornece a função gen_random_uuid()
    enable_extension 'pgcrypto' unless extension_enabled?('pgcrypto')
  end
end

# 2. Definir UUID como padrão global (opcional, recomendado)
# config/application.rb
config.generators do |g|
  g.orm :active_record, primary_key_type: :uuid
end

# NOTA: Caso deseje por ambiente altere em: config/environments/[production | development].rb
Rails.application.config.active_record.primary_key_type = :uuid
```

#### Converter projeto existente

Em sistemas já em produção com `bigint`, a migração exige:

- Criar nova coluna uuid
- Popular com `gen_random_uuid()`
- Atualizar FKs
- Recriar índices e constraints
- Trocar PK
- Remover coluna antiga

```ruby
# Adicionando uma coluna UUID a um modelo existente
class AddUuidToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :uuid, :uuid, default: "gen_random_uuid()", null: false
  end
end

# Gerando UUID fora do Active Record
require 'securerandom'
# Generates a version 4 (random) UUID
uuid_v4 = SecureRandom.uuid

# Generates a version 7 (time-based) UUID in newer Ruby versions
uuid_v7 = SecureRandom.uuid_v7
```

### Enum

```ruby
class Conversation < ActiveRecord::Base
  # Cria um enum cujo valor no Banco de Dados será o 'key' do 'value'
  enum :status, { active: 0, active: 1 }
end

# Gera métodos para definir e checar automaticamente
conversation.active!    # Define o valor de "status" para active (0)
conversation.archived!  # Define o valor de "status" para archived (1)
conversation.active?    # Retorna "true" ou "false" dependendo do valor do "status"
conversation.status     # Saída: "archived"
```

### Scopes

São consultas reutilizáveis e encadeáveis (`ActiveRecord::Relation`) definidas no modelo para encapsular lógica de filtro do banco de dados de forma limpa, expressiva e consistente com o estilo Rails.

Eles servem para nomear queries, evitar repetição e manter regras de negócio relacionadas à persistência dentro do modelo.

```ruby
# Definição no *Model*
class Order < ApplicationRecord
  # Padrão
  scope :published, -> { where(published: true) }
  # Com parâmetro
  scope :by_author, ->(user_id) { where(author_id: user_id) }
  # Condicional
  scope :by_status, ->(status) { status.present? ? where(status:) : all }
  # Condicional e parâmetro
  scope :recent, ->(days_ago) { where("published_at >= ?", Time.current - days_ago.days) }
end

# Utilização no *Controller*
def index
  @orders = Order.by_author(1).published.recent(7).limit(20)
end
```

### Active Record Encryption (Rails 7+)

Um recurso integrado do Ruby on Rails que fornece criptografia em nível de aplicação para dados sensíveis armazenados no banco de dados. Ele criptografa e descriptografa de forma transparente atributos específicos do modelo, adicionando uma camada crucial de segurança contra acesso não autorizado ao banco de dados ou aos logs.

A criptografia ocorre:

- Antes de persistir no banco
- A descriptografia ocorre automaticamente ao ler

```shell
# Geração de chaves
bin/rails db:encryption:init
```

```yml
# Opção 1
# bin/rails credentials:edit
active_record_encryption:
  primary_key: xxxxxxxxxxxxxxxxx
  deterministic_key: xxxxxxxxxxxxxxxxx
  key_derivation_salt: xxxxxxxxxxxxxxxxx

# Opção 2
# Variáveis de ambiente
ACTIVE_RECORD_ENCRYPTION_PRIMARY_KEY: "xxxxxxxxxxxxxxxxx"
ACTIVE_RECORD_ENCRYPTION_DETERMINISTIC_KEY: "xxxxxxxxxxxxxxxxx"
ACTIVE_RECORD_ENCRYPTION_KEY_DERIVATION_SALT: "xxxxxxxxxxxxxxxxx"
```

```ruby
class User < ApplicationRecord
  # O mesmo valor gera hashes diferentes
  encrypts :cpf

  # O mesmo valor gera hashes iguais
  encrypts :cpf, deterministic: true
end
```

## Controllers

O Controller atua como orquestrador da requisição. Ele recebe a request HTTP, coordena chamadas aos models, decide o fluxo da aplicação e prepara os dados para a resposta. Controllers devem ser finos: sem lógica de negócio pesada, apenas controle de fluxo, autorização, autenticação e seleção da resposta (HTML, JSON, etc.).

São compostos por actions, que são métodos públicos associados a rotas. Por convenção, utilizam actions RESTful, promovendo padronização e previsibilidade.

> OBS: O nome da _view_ **deve** ser o mesmo da **action** do _controller_, por exemplo, index.

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

    # Associação has_many
    @customers = Customer.includes(:items)    # Resolve query N+1
end

# View "customers/index.html.erb"
<% @customers.each do |customer| %>
    <%= customer.name %>
<% end %>
```

### Actions

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

### Helpers

| Helper                    | Tipo            | Finalidade                                     |
| ------------------------- | --------------- | ---------------------------------------------- |
| `before_action`           | Callback        | Executa método antes da action                 |
| `after_action`            | Callback        | Executa método após a action                   |
| `around_action`           | Callback        | Executa código antes e depois da action        |
| `skip_before_action`      | Callback        | Ignora um before_action específico             |
| `prepend_before_action`   | Callback        | Executa antes dos demais before_action         |
| `rescue_from`             | Tratamento erro | Captura exceções e define resposta customizada |
| `helper_method`           | Exposição       | Disponibiliza método do controller para a view |
| `respond_to`              | Resposta        | Define formatos de resposta (html, json, etc.) |
| `render`                  | Resposta        | Renderiza uma view ou payload                  |
| `redirect_to`             | Resposta        | Redireciona para outra rota/URL                |
| `head`                    | Resposta        | Retorna resposta sem corpo (ex: head :ok)      |
| `params`                  | Request         | Acesso aos parâmetros da requisição            |
| `session`                 | Estado          | Armazena dados na sessão                       |
| `cookies`                 | Estado          | Manipula cookies                               |
| `flash`                   | Estado          | Mensagens temporárias entre requisições        |
| `request`                 | Request         | Objeto da requisição HTTP                      |
| `response`                | Response        | Objeto da resposta HTTP                        |
| `protect_from_forgery`    | Segurança       | Proteção contra CSRF                           |
| `skip_forgery_protection` | Segurança       | Desativa proteção CSRF                         |
| `send_data`               | Utilitário      | Envia dados binários (PDF, CSV, etc.)          |
| `send_file`               | Utilitário      | Envia arquivos                                 |
| `logger`                  | Log             | Acesso ao logger da aplicação                  |
| `render_to_string`        | Renderização    | Renderiza view para string                     |
| `url_for`                 | Roteamento      | Gera URLs manualmente                          |
| `polymorphic_url`         | Roteamento      | Gera URLs para recursos polimórficos           |

## Views

As views devem ser simples e focadas em exibição, delegando lógica reutilizável para helpers, partials e layouts.

### Embedded Ruby

É um sistema de template que combina a linguagem Ruby com texto. Sua extensão é `.erb`.

| Sintaxe ERB        | Finalidade                    | Exemplo                        |
| ------------------ | ----------------------------- | ------------------------------ |
| `<% %>`            | Executar código Ruby          | `<% if user.admin? %>`         |
| `<%= %>`           | Executar e imprimir resultado | `<%= user.name %>`             |
| `<%- -%>`          | Executar sem quebra de linha  | `<%- items.each do \|i\| -%>`  |
| `<%= raw %>`       | Imprimir HTML sem escape      | `<%= raw("\<b>Texto\</b>") %>` |
| `<%= html_safe %>` | Marca string como segura      | `"\<b>ok\</b>".html_safe`      |
| `<%# %>`           | Comentário ERB                | `<%# comentário %>`            |

### Partials

São arquivos com a extensão `*.html.erb` cujo nome começam com underline (\_).

```erb
# app/view/customer/new.html.erb
<%= render "form" %>

<!-- NOTA: Caso a view tenha acesso á variavel @user, a partial também terá -->
<%= render "form", @user %>

<%= render "form", user: @user %>
<%= render partial: "form", locals: { user: @user } %>
```

### Formulário

`form_with` Substitui `form_for` e `form_tag`. Usa sempre `FormBuilder`.

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
select("model_name", "attribute", %w(option option option), { include_blank: true })

# "f" representa o model no closure "form_for". ":attribute" é o symbol com o nome do atributo do model. "@person.sex" altera o "M" para "Masculino" (neste caso) para quando for modificar o model
f.select(:attribute, options_for_select([["Masculino", "M"], ["Feminino", "F"]], @person.sex), {include_blank: "Selecione"})

# Collection select (nome_do_campo, modelos_para_popular, valor, nome_da_option, include_blank)
f.collection_select(:model_id, @models, :id, :name, include_blank: true)
# OBS: "include_blank" pode ser substituido para "prompt" que contém uma mensagem padrão. Evite chamar o model dentro da view, utilize uma variável que contenha a informação desejada
```

#### Helpers

São métodos do FormBuilder.

| Categoria         | Helper                      | Descrição                         |
| ----------------- | --------------------------- | --------------------------------- |
| Texto / Numérico  | `text_field`                | Campo de texto simples            |
| Texto / Numérico  | `text_area`                 | Campo de texto multilinha         |
| Texto / Numérico  | `number_field`              | Campo numérico                    |
| Texto / Numérico  | `range_field`               | Campo numérico em forma de slider |
| Texto / Numérico  | `password_field`            | Campo de senha                    |
| Texto / Numérico  | `email_field`               | Campo para e-mail                 |
| Texto / Numérico  | `telephone_field`           | Campo para telefone               |
| Texto / Numérico  | `url_field`                 | Campo para URL                    |
| Texto / Numérico  | `search_field`              | Campo de busca                    |
| Data / Tempo      | `date_field`                | Seleção de data                   |
| Data / Tempo      | `time_field`                | Seleção de horário                |
| Data / Tempo      | `datetime_field`            | Seleção de data e hora            |
| Data / Tempo      | `datetime_local_field`      | Data e hora no fuso local         |
| Data / Tempo      | `month_field`               | Seleção de mês                    |
| Data / Tempo      | `week_field`                | Seleção de semana                 |
| Seleção           | `select`                    | Dropdown simples                  |
| Seleção           | `collection_select`         | Dropdown baseado em coleção       |
| Seleção           | `grouped_collection_select` | Dropdown agrupado por coleção     |
| Seleção           | `time_zone_select`          | Seleção de fuso horário           |
| Booleano          | `check_box`                 | Caixa de seleção                  |
| Booleano          | `radio_button`              | Botão de opção exclusiva          |
| Upload / Arquivos | `file_field`                | Upload de arquivos                |
| Oculto / Auxiliar | `hidden_field`              | Campo oculto                      |
| Oculto / Auxiliar | `color_field`               | Seletor de cor                    |
| Envio / Ação      | `submit`                    | Botão de envio do formulário      |
| Envio / Ação      | `button`                    | Botão genérico de ação            |

#### Formulários complexos e Nested Attributes

**Problemática**: Ao criar um usuário através de um formulário com os campos "Nome, e-mail e telefone" e "Endereço, cód. postal, referência", como saber quais dados são do modelo Usuário e quais dados são do modelo Endereço?

Quando um modelo tem o helper **has_one** (no caso, Usuário tem apenas um endereço) o método **build\_\*** (\* é o nome do modelo) fica acessível para o modelo. O método faz com que ao criar o Endereço e salvar o usuário sejam salvos duas entidades diferentes no banco de dados.

> É preciso atualizar o controller para permitir os novos campos vindo do formulário.

```ruby
# Model
class Father < ApplicationRecord
  has_many :children, inverse_of: :father, dependent: :destroy
  accepts_nested_attributes_for :children, allow_destroy: true

  # `allow_destroy: true` Permite excluir registros associados através do formulário do `father`
end

class Child < ApplicationRecord
  belongs_to :father
end

# Controller
class FathersController < ApplicationController
  def new
    @father = Father.new
    @father.children.build # cria ao menos 1 child no form
  end

  def create
    @father = Father.new(father_params)
    if @father.save
      redirect_to @father
    else
      render :new
    end
  end

  private

  def father_params
    params.require(:father).permit(
      :name,
      children_attributes: [:id, :name, :_destroy]
    )
  end
end
```

> OBS: Utilize `Stimulus` para adicionar/remover _children_ dinamicamente na view.

```erb
<%= form_with model: @father do |f| %>
  <div>
    <%= f.label :name, "Father name" %>
    <%= f.text_field :name %>
  </div>
  <h3>Children</h3>
  <%= f.fields_for :children do |child_form| %>
    <div class="child-fields">
      <%= child_form.label :name, "Child name" %>
      <%= child_form.text_field :name %>

      <%# "Exclui o Child ao salvar o Father" %>
      <%= child_form.check_box :_destroy %>
      <%= child_form.label :_destroy, "Remove" %>
    </div>
  <% end %>
  <%= f.submit %>
<% end %>
```

### yield

`yield` é o ponto de inserção onde o conteúdo da view é renderizado dentro do layout.

- `yield`: Onde renderizar
- `content_for`: O que renderizar

```erb
<!-- app/views/layouts/application.html.erb -->
<head>
  <%= yield :head %>
</head>
```

```erb
<!-- app/views/minha_view/index.html.erb -->
<% content_for :head do %>
  <title>A simple page</title>
<% end %>

<p>Hello, Rails!</p>
```

### Helpers

| Helper                  | Descrição                                 | Exemplo                                                 |
| ----------------------- | ----------------------------------------- | ------------------------------------------------------- |
| `link_to`               | Gera um link HTML                         | `link_to "Home", root_path`                             |
| `button_to`             | Gera um botão que dispara uma requisição  | `button_to "Delete", post_path(@post), method: :delete` |
| `image_tag`             | Renderiza uma imagem                      | `image_tag "logo.png", alt: "Logo"`                     |
| `image_url`             | Retorna a URL de uma imagem               | `image_url("logo.png")`                                 |
| `render`                | Renderiza partials ou templates           | `render "shared/header"`                                |
| `pluralize`             | Pluraliza palavras com base em quantidade | `pluralize(2, "erro")`                                  |
| `truncate`              | Trunca texto longo                        | `truncate(text, length: 30)`                            |
| `simple_format`         | Converte texto em parágrafos HTML         | `simple_format(text)`                                   |
| `number_to_currency`    | Formata número como moeda                 | `number_to_currency(100)`                               |
| `number_to_percentage`  | Formata número como porcentagem           | `number_to_percentage(50)`                              |
| `number_with_delimiter` | Adiciona separador de milhar              | `number_with_delimiter(1000000)`                        |
| `time_ago_in_words`     | Tempo relativo (ex: "2 days ago")         | `time_ago_in_words(@post.created_at)`                   |
| `l`                     | Localiza datas/horas (I18n)               | `l(Time.current, format: :short)`                       |
| `sanitize`              | Remove HTML inseguro                      | `sanitize(user_input)`                                  |
| `raw`                   | Renderiza HTML sem escapar                | `raw("<strong>HTML</strong>")`                          |
| `safe_join`             | Junta strings HTML com segurança          | `safe_join(items, tag.br)`                              |

[Lista completa](https://guides.rubyonrails.org/action_view_helpers.html)

## Scaffold

Scaffold no Ruby on Rails é um gerador automático de código que cria, de forma rápida e padronizada, toda a estrutura básica de um recurso CRUD, incluindo `model`, `migration`, `controller`, `views`, `rotas` e `testes iniciais`, sempre seguindo as convenções do framework; seu principal objetivo é acelerar o desenvolvimento inicial.

![Scaffold](/assets/images/Scaffold.jpeg)

```shell
# Para criar um Scaffold, utilize o seguinte comando
rails generate scaffold Modelo nome:tipo nome:tipo nome:tipo ...
rails g scaffold Article title:string body:text
```

## Rotas

Rotas definem como requisições HTTP (URL + verbo) são mapeadas para actions de controllers. Elas são o ponto de entrada da aplicação e conectam o mundo externo (web/API) à camada de controle.

As rotas também geram helpers de URL (`users_path`, `user_path(@user)`), usados em views e controllers.

> Arquivo: config/routes.rb

```ruby
# Rota raiz
root "view#action"

# Rota simples
get "/about", to: "pages#about"
get "/about" => "pages#about"

# Rotas RESTful (Gera automaticamente: index, show, new, create, edit, update, destroy)
resources :users

# Restringir actions
resources :users, only: [:index, :show]         # Apenas: index e show
resources :users, except: [:index, :show]       # Todos, exceto: index e show

# Rotas customizadas
get "login", to: "sessions#new"
post "login", to: "sessions#create"

# Rotas aninhadas (Evite aninhamentos profundos)
# /users/1/posts
resources :users do
  resources :posts
end

# Collection e member
resources :orders do
  # Define rotas que atuam sobre o conjunto inteiro de recursos, sem exigir `:id`
  # /orders/recent
  collection do
    get :recent
  end

  # Define rotas que atuam sobre um recurso específico, exigindo `:id`
  # /orders/1/cancel
  member do
    post :cancel
  end
end

# Agrupa rotas com prefixo de URL e namespace de controller
# URL: /admin/users
# Controller: Admin::UsersController
namespace :admin do
  resources :users
end

# Agrupa rotas sem obrigar namespace de controller
# URL: /admin/users
# Controller: UsersController
scope "/admin" do
  resources :users
end

# URL: /users
# Controller: Admin::UsersController
scope module: :admin do
  resources :users
end

# Equivale a `namespace`
# URL: /admin/users
# Controller: Admin::UsersController
scope "/admin", module: :admin do
  resources :users
end

# Restringe rotas com base em condições (regex, ip, etc.)
constraints subdomain: "api" do
  resources :users
end
```

[Guia completo](https://guiarails.com.br/routing.html)

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

## Active Record

O Active Record é o ORM (Object-Relational Mapping) padrão do Ruby on Rails. Cada classe do sistema representa uma tabela do banco de dados e cada instância dessa classe representa um registro (linha) dessa tabela.

Além de mapear objetos para registros persistidos, o Active Record encapsula lógica de consulta, validação, callbacks, associações e transações diretamente no model, centralizando a camada de persistência.

A diferença entre **Active Record** e **Active Model** está no escopo de responsabilidade. Active Record é responsável por persistência em banco de dados relacional, incluindo mapeamento objeto-relacional e query interface. Já o Active Model fornece funcionalidades de modelagem — como validações, callbacks, naming e conversões — mas sem obrigatoriedade de persistência em banco.

```ruby
# Operações CRUD
# Create
model = Model.create(name: "John Doe", age: 20)     # Cria o objeto no Banco de Dados e retorna a instância do modelo criado
model = Model.new(name: "John Doe", age: 20)        # Instância o objeto e depois salva no banco de dados
model.save
Model.insert(title: "The Lord of the Rings", author: "J.R.R. Tolkien")                # Insere sem validações e callbacks
Model.insert_all([{ title: "The Lord of the Rings", author: "J.R.R. Tolkien" }])

# Read
Model.all                     # Retorna um array com *todos* os registros
Model.find_each               # Retorna um batch de 1000 elementos (padrão)
Model.ids                     # Retorna um array contendo todos os ids
Model.first                   # Retorna o primeiro elemento
Model.last                    # Retorna o último elemento
Model.find(1)                 # Busca por id. Aceita múltiplos argumentos
Model.find_by(name: "John")   # Busca por atributo. Retorna o primeiro elemento encontrado
Model.where(name: :John)      # Busca por atributo. Retorna um array

# Update
model = Model.find_by(title: "The Lord of the Rings")
model.update(title: "The Lord of the Rings: The Fellowship of the Ring")
Model.update_all(status: "already own")

# Delete
model = Model.find_by(title: "The Lord of the Rings")
model.destroy
Model.destroy_by(author: "Douglas Adams")
Model.destroy_all
Model.delete_all              # Remove sem validações e callbacks

# Método "where" com "like"
Model.where("name like '%#{params[:name]}%'")     # ERRO: Perigo de SQL Injection
Model.where("name like ?", "%#{params[:name]}%")  # Correto
```

## Migration

É um mecanismo de versionamento do banco de dados que permite criar, alterar e manter a estrutura das tabelas de forma organizada e reprodutível por meio de código Ruby, garantindo consistência entre ambientes e facilitando a evolução do schema ao longo do desenvolvimento

### Adicionando / removendo campos

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

### Aplicando migrações pendentes

> NOTA: Observe que "VERSION=" é o **timestamp** da migração.

```shell
# Deixa o banco de dados igual ao script schema. A tabela pode ser criada, modificada ou removida
bin/rails db:migrate

# Migração específica
rails db:migrate:up VERSION=20251225246060

# Rollback específico
rails db:migrate:down VERSION=20251225246060

# Quantia de rollbacks
rails db:rollback STEP=n

# Quantia de migrações a partir da última definida no "schema"
rails db:migrate:redo STEP=n
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

## Solid Cache (Rails 8+)

> TODO

O armazenamento em cache consiste em guardar o conteúdo gerado durante o ciclo de pedido-resposta e reutilizá-lo ao responder a pedidos semelhantes.

O armazenamento em cache é uma das maneiras mais eficazes de melhorar o desempenho de um aplicativo.

[Outros tipos de cache](https://guides.rubyonrails.org/caching_with_rails.html)

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

## i18n (Internationalization)

i18n (internationalization) é o mecanismo utilizado para adaptar uma aplicação a múltiplos idiomas e formatos regionais, como textos, datas, números e moedas, sem alterar a lógica do sistema. No Ruby on Rails, o i18n é nativo e faz parte do core do framework.

As traduções são definidas em arquivos YAML localizados, por padrão, em `config/locales`. Cada arquivo representa um idioma e contém chaves organizadas hierarquicamente.

> Caso a chave não seja encontrada, será renderizado o nome da chave e não seu valor.

```ruby
# Definindo locale padrão global (config/application.rb)
config.i18n.default_locale = :"pt-BR"
config.i18n.available_locales = [:"pt-BR", :en]

# Tradução em métodos
I18n.t('caminho.da.chave')    # Tradução - textos
I18n.l()                      # Localização - datas, horas e números

# Tradução nas views
t(:caminho_da_chave)
l()
```

[i18n pt-BR](https://github.com/svenfuchs/rails-i18n/blob/master/rails/locale/pt-BR.yml)

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

#### Estrutura de pastas

No RSpec, a estrutura de pastas não é apenas organizacional; ela define o comportamento e os helpers que estarão disponíveis para o seu teste.

Quando o RSpec "vê" um arquivo dentro de `spec/requests`, ele automaticamente atribui o `type: :request`, o que libera métodos como `get`, `post`, `patch` e o objeto `response`.

```
spec/
├── factories/          # (Se usar FactoryBot)
├── models/             # Testes de lógica de banco e validações (type: :model)
├── requests/           # Testes de integração/API/Controllers (type: :request)
└── rails_helper.rb     # Configuração principal
```

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

#### Requisições (Devise)

```ruby
# spec/rails_helper.rb
config.include Devise::Test::IntegrationHelpers, type: :request

# spec/requests/posts_spec.rb
RSpec.describe "Posts", type: :request do
  # Cria um "User" e "Post" a cada novo teste. Também pode ser utilizado dentro do escopo "describe"
  let(:user) { User.create(email: "user@example.com", password: "password") }
  let(:post) { Post.create(title: "Title", body: "Body") }

  describe "GET /post" do
    it "Redirect to login page" do
      # "post" faz referência ao "let(:post)"
      get post_path(post)
      expect(response).to redirect_to(new_user_session_path)
    end

    it "Access the post page" do
      # "sign_in" é um helper Devise adicionado no "spec/rails_helper.rb"
      # "user" faz referência ao "let(:user)"
      sign_in user

      # get post_path(id: 1)
      # get post_path(slug: "test")
      get post_path(post)
      expect(response).to have_http_status(:ok)
    end

    it "Don't allow user with :reader role" do
      sign_in user

      get new_post_path(post)
      expect(response).to have_http_status(:found)
    end
  end
end
```

### GitHub Actions (CI/CD)

GitHub Actions é a plataforma de CI/CD nativa do GitHub.

No contexto de CI (Continuous Integration), ele serve para:

- Executar testes automaticamente
- Validar builds a cada `push` ou `pull_request`
- Detectar erros antes do merge
- Garantir que o código no repositório principal esteja estável

> Ele executa workflows definidos em YAML dentro do próprio repositório (.github/workflows/ci.yml).

Ambiente de execução:

- Máquinas virtuais efêmeras
- Criadas sob demanda
- Sistema operacional típico: `ubuntu-latest`, `windows-latest` e `macos-latest`
- "Roda" em uma VM isolada
- Não compartilha estado com outros jobs
- É destruída ao final da execução

> A execução de CI é gratuita em repositórios públicos, para repositórios privados (free) o limite é de 2.000 minutos/mês.

Desativando CI (Escolha uma das opções):

1. Remover _.github/workflows/ci.yml_
2. (GitHub) Settings > Actions > General > (Actions permissions) Disable Actions

## Deploy

Consiste em preparar o **ambiente de produção**, publicar o código e garantir que a aplicação esteja pronta para atender usuários de forma estável e segura.

Etapas:

- [ ] Configurar OS
- [ ] Dependências
- [ ] Variáveis de ambiente
- [ ] Banco de dados
- [ ] Servidor web
- [ ] Serviços auxiliares (background jobs, cache, etc.)
- [ ] Estratégias de: rollback, failover, playbooks e critérios de "Go/No-Go"
- [ ] Deploy e validação pós-deploy
- [ ] Monitoramento contínuo

> NOTA: Crie uma variável de ambiente que representa o arquivo config/master.key

```shell
# Instalação de Dependências
RAILS_ENV=production bundle install

# Compilação de Assets (CSS/JS)
RAILS_ENV=production bundle exec rake assets:precompile
RAILS_ENV=production bundle exec rake assets:clean          # Automatico em Rails 6+

# Banco de Dados
RAILS_ENV=production bundle exec rails db:prepare
```

[Guia completo](https://github.com/ankane/production_rails)

## Rake Task

Rake tasks são **tarefas automatizadas** escritas em Ruby e executadas via Rake (Ruby Make), usadas para orquestrar rotinas operacionais fora do fluxo normal da aplicação web.

No contexto do Ruby on Rails, rake tasks servem para executar processos repetitivos, administrativos ou de manutenção, como migrações de banco, carga de dados, limpeza, integrações e scripts pontuais. Elas ficam, por convenção, em `lib/tasks/*.rake` e são definidas declarando um namespace, a tarefa e suas dependências.

Rake tasks são síncronas, executam no processo que as chama e não substituem jobs em background; quando a tarefa é pesada ou demorada, o padrão é usá-las apenas como disparadoras de jobs (por exemplo, Sidekiq).

```shell
# Listando tasks
rails -T

# Gerando rake task
rails g task <namespace> <task_name>

# Exemplo (Gera lib/tasks/utils.rake)
rails g task utils say_hello
```

```ruby
# lib/tasks/utils.rake
namespace :utils do
  desc "Say 'Hello World' n times"        # Descrição ao utilizar 'rake -T'
  # Verifica ambiente de execução e variáveis de ambiente
  task say_hello: :environment do
    if Rails.env.development?             # Verifica o ambiente
      ENV['QTD'].to_i.times do |i|        # Valor da chave 'QTD' ao utilizar o comando rake (ARGV contém todos argumentos)
        puts "Hello World"
      end
    end
  end

  # Argumentos
  task :generate, [:year, :month] => :environment do |_, args|
    puts "Ano: #{args[:year]}, Mês: #{args[:month]}"
  end
end

# Uso: rake utils:say_hello QTD=10        # Variável de ambiente
# Uso: rake "utils:generate[2025,15]"     # Argumento
```

## Cron Jobs

Cron Jobs são utilizados para agendar a execução de tarefas recorrentes fora do ciclo de requisição HTTP, normalmente para rotinas operacionais, manutenção e rake tasks. O **cron é um agendador do sistema operacional Unix/Linux** que dispara comandos em horários definidos, independentemente da aplicação estar recebendo requisições.

Embora seja possível executar lógica pesada diretamente no cron, o padrão de mercado é utilizá-lo apenas como gatilho, delegando o processamento para jobs em background (como Sidekiq).

```shell
# Edita o cron
crontab -e

# Executar a task todos os dias às 09:00
0 9 * * * cd /path/to/my_app && bin/rails "utils:say_hello QTD=10" >> log/cron.log 2>&1
```

### Sidekiq

> TODO

## Dicas

- [Ruby Toolbox](https://www.ruby-toolbox.com/categories): RubyGems por categorias
- [Simple CSS](https://github.com/kevquirk/simple.css/wiki/Getting-Started-With-Simple.css): Estilização sem customização inicial

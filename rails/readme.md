# TODO

- Separar conteúdo relacionado a "gems"
- Lista de gemas [clique aqui](https://www.youtube.com/watch?v=dMyDS4oYlvo&list=PLe3LRfCs4go-mkvHRMSXEOG-HDbzesyaP&index=22)
- gem faker: Informações falsas ideais para seed

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
- rails destroy migration [nome_da_migration]: TODO
- rails console (ou apenas "c"): Prompt de comando para a aplicação Rails. Todas as classes presentes no app Rails são carregadas e ficam prontas para uso no console.
- rails db:[create | migrate | seed]: TODO
- rails assets:precompile: TODO

## Banco de Dados

Para configurar o banco de dados, modifique o arquivo **config/database.yml**.

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

#### Criando Rake Task

TODO

## CoC (Convention over Configuration)

É um paradigma de projeto que visa diminuir o número de decissões que os desenvolvedores devem fazer, ganhando simplicidade sem perder a flexibilidade.

Em Rails, os comandos geradores de models, views, controlers, schemas, etc. é um CoC, pois, não há a necessidade de desenvolver todo um código _boilerplate_.

### Scaffold (Andaime)

No contexto Rails é como se o app recém gerado estivesse pré-moldado para que você o personalize, sem a necessidade de criá-lo do absoluto zero.

Gera os arquivos necessários (MVC) e configura as rotas para realizar CRUD da entidade criada e também o arquivo de _migrate_. É necessário realizar a migração para o banco de dados (próx. conteúdo).

![Scaffold](../images/Scaffold.jpeg)

> OBS: O nome do modelo é no singular, mas no banco de dados é no plural (convenção).

```shell
# Para criar um Scaffold, utilize o seguinte comando
rails generate scaffold nome:tipo nome:tipo nome:tipo ...
```

#### Adicionando/removendo campos

```shell
# Sintaxe
# Troque YYY pelo nome do model. Adicione o "s" em "Field" caso seja mais de um campo
rails generate migration AddFieldToYYY atribute:type
rails generate migration RemoveXXXFromYYY

# Exemplo
rails g migration addFieldToPerson name:string

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

```shell
# app/view/customer/new.html.erb
<%= render "form" %>

# app/view/customer/_form.html.erb (É um "mini-controller" contém lógica de
# programação e renderização. No contexto React, seria como um componente.) ...
```

### Formulário

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

### Associações

- belongs_to: Pertence
- has_many: Tem muitos

![Associação](/images/Associacao.jpeg)

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

## Controllers

Local onde está presente as **ações** do sistema. Para toda _ação_, haverá uma _view_ relacionada a ação.

O arroba "@" antes do nome da variável indica que a variável é uma variável de instância. Em Rails, ao criar uma variável de instância no controller, a view também terá acesso a ela.

> OBS: O nome da _view_ **deve** ser o mesmo do **método** do _controller_, no caso, index.

```ruby
# Controller "customers_controller.rb"
def index
    @customers = Customer.all
end

# View "customers/index.html.erb"
<% @customers.each do |customer| %>
    <%= customer.name %>
<% end %>
```

### before_action x before_filter

> São o mesmo elemento. before*filter até rails 3.x e before_action >= 4.x. São filtros exclusivo do \_Rails*.

Em Rails, filtros são métodos que são executados antes, depois ou ambos os casos (around) de uma ação de controle. Evita repetição de código (DRY).

```ruby
# before_action :method_to_include, only: [:method_name, :method_name]

class Customer < ApplicationController
  before_action :set_customer, only: [:hello]
  #after_action :set_customer, only: [:hello]
  #around_action :set_customer, only: [:hello]

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

```
# View - link_to(name, path)
<%= link_to "Texto", :action => "action_name" %>

# <%= link_to "Texto", "/customers" %> >> 'customers_path' é gerado automaticamente pelo Rails (/rails/info/routes)
<%= link_to "Texto", customers_path %>
```

#### Criando helper

Os _helpers_ encontram-se na pasta _/app/helpers_. Cada model tem seu helper e o helper criado dentro de "application_helper.rb" será um helper global. O método criado pode ser chamado na view especificada ou em todas (caso tenha sido criado em "application_helper").

## Active Record

Active Record é um framework presente no Ruby on Rails e é responsável por tratar a persistência das informações no Banco de Dados.

Active Record permite o desenvolvedor crie DBs sem necessitar de SQL, pois, utiliza DSL (Doman Specif Language)

> Active Record também é um padrão de projeto para Banco de Dados relacionais. **É onde ocorre as validações**.

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

### Validações (Active Record Validations)

Active Record Validation verifica o valor do atributo antes de salvá-lo no banco de dados, as alterações são realizadas dentro do model.

Lista de critérios possíveis [aqui](https://guides.rubyonrails.org/active_record_validations.html).

```ruby
# Modelo
class Person < ApplicationRecord
  # Valida que o atributo "name" não é vazio (nil)
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
end

# Execução
Person.new(name: "John Doe").valid? # true
Person.new(name: nil).valid?        # false
```

### Métodos de model

TODO: Validações e mensagens de erro personalizadas

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

## Framework front-end

### Twitter Bootstrap

Framework web front-end para desenvolver aplicativos responsivos. Acesse [aqui](https://getbootstrap.com/2.0.2/).

### Rails Composer

App terceiro que gera template de views.

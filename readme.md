# Ruby

## História

> TODO

Características:

- É uma linguagem interpretada
- Orientada a objeto (Tudo é objeto, inclusive números)

Sintaxe:

> TODO

## REPL: IRB e PRY

- REPL: Read-eval-print-loop - Permite executar código Ruby direto pelo promp de comando. Alternativas:
- - IRB: Interactive Ruby Shell
- - PRY: É uma Ruby Gem parecido com o IRB, porém, há recursos adicionais como: Destaque de sintaxe, preenchimento automático, depuração, etc...

## Array e Hash

### Array

É uma coleção ordenada por qualquer objeto indexado por um inteiro. Cada elemento do array é referenciado e indexado por um índice.

> OBS: 'puts' é análogo ao 'console.log("...")' do JavaScript.

```ruby
# Criando Array. Quantia de elementos não definido
array_a = []
array_b = Array.new
array_c = %w("Cada palavra se torna um elemento indexado")

# Inserindo dados. Permite diferente tipos de dados
array_a.push(777)
array_a.push("ruby")
array_a[2] = true

# Imprimindo array
puts array_a
puts array_a[0]
```

### Hash

É uma coleção de pares chave-valor. É similar ao array, porém, seus índices são definidos arbitráriamente.

```ruby
# Criando hash
hash_a = {"chave_a" => "valor", "chave_b" => 123, "chave_c" => false}

# Acessando hash
puts hash_a
puts hash_a["chave_a"]
```

## Métodos e blocos

Métodos são blocos de código que realizam uma tarefa específica e podem ser reutilizados em diferentes partes de um programa. Eles são semelhantes a funções em outras linguagens de programação.

Um método pode retornar um valor usando a palavra-chave return. Se return não for usado explicitamente, o método retorna o valor da última expressão avaliada.

### Métodos com Blocos

> TODO

> OBS: Parâmetros são as variáveis que a função espera receber. Argumentos são os valores passados à essas variáveis.

# Ruby on Rails

## História

Ruby on Rails (ou simplesmente Rails) é um framework de desenvolvimento web escrito em Ruby, lançado em 2004 por David Heinemeier Hansson (também conhecido como DHH) e a versão 1.0 foi lançada em dezembro de 2005. Ele foi criado como parte do desenvolvimento da ferramenta de gerenciamento de projetos Basecamp pela empresa 37signals (hoje Basecamp).

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

# Ruby

> Versão de estudo: 3.1.1 ([Documentação](https://ruby-doc.org/core-3.1.1/))

## História

Foi publicada em 1995 por Yukihiro Matsumoto ("Matz") no Japão. Ela combina ideias de várias linguagens como Perl, Smalltalk, Eiffel, Ada e Lisp, e é conhecida por sua sintaxe legível e elegante.

Inicialmente, Ruby não era uma linguagem bem documentada, pois Matz preferia escrever programas a documentação. Ele expressa a sua gratidão a Dave Thomas e Andy Hunt, autores do livro "Programming Ruby" (também conhecido como "PickAxe"), por terem apresentado Ruby em grande escala fora do Japão.

Características:

- Interpretada
- Alto nível
- Tipagem dinâmica
- Multiparadigma, mas com ênfase em Orientação a objetos
- Multithread
- Gerenciamento de Pacotes com [RubyGems](https://rubygems.org/?locale=pt-BR)
- Extensão do arquivo: **.rb**

## Preparando o ambiente

Observações:

- Ruby e Ruby on Rails (RoR) é melhor executado em sistemas GNU/Linux
- Caso utilize Windows, é recomendado o uso de [WSL](https://learn.microsoft.com/pt-br/windows/wsl/about) ou [Docker](https://www.docker.com/)

Passos:

1. Instalar Ruby com um gerenciador de versões como [rvm](https://rvm.io/rvm/install) ou [rbenv](https://github.com/rbenv/rbenv)
2. Instalar a Ruby Gem "bundler": gem install bundler

Executando script ruby:

```shell
ruby meu_script.rb
```

## REPL: IRB e PRY

- REPL (Read-Eval-Print-Loop): Permite que você digite código Ruby em um prompt e veja os resultados imediatamente
- - IRB (Interactive Ruby Shell): Ferramenta **padrão** do Ruby para executar códigos no prompt
- - PRY: É uma [Ruby Gem](https://rubygems.org/gems/pry) parecido com o IRB, porém, há recursos adicionais como: Destaque de sintaxe, preenchimento automático, depuração, entre outros

## Syntax

Ruby Style Guide: Um guia sobre como escrever seu código Ruby [Link](https://github.com/rubocop/ruby-style-guide).

### Comments

```ruby
# Comentário de única linha

=begin
  Comentário de
  várias linhas
  ...
=end
```

### Variables & Data Types

Os nomes de variáveis locais devem começar com uma letra minúscula ou um sublinhado \_. Variáveis de instância começam com @ e variáveis de classe com @@. Variáveis globais começam com $. É uma conveção utilizar **snake_case** para nomes de variáveis e métodos (funções). Ex.: minha_variavel.

```ruby
# Números
inteiro = 1     # Integer
decimal = 3.14  # Float

# Strings
palavra1 = 'Hello'
palavra2 = ", "
palavra3 = %q{world!}

# Boolean
is_true = true
is_false = false

# Vazio
# OBS: Em Ruby, nil é um objeto (a instância singleton da classe NilClass)
vazio = nil
```

#### Symbol

> TODO

### Casting

```ruby
3.14.to_i()           # Float para Integer
3.to_f()              # Integer para Float
3.0.to_s()            # Float para String
"4".to_i()            # String para Integer
"4.2".to_f()          # String para Float

range = 1..5
array = range.to_a()  # Range para Array

array = [[:a, 1], [:b, 2], [:c, 3]]
hash = array.to_h()   # 2d Array para hash
```

### Concat (Interpolation)

```ruby
palavra1 + palavra2 + palavra3        # Resultado: "Hello, world!"
"A primeira palavra é: #{palavra1}"   # Resultado: "A primeira palavra é: Hello"
"1" + 2                               # Resultado: *TypeError*
"1, 2, #{3}"                          # Resultado: "1, 2, 3"
```

### Printing

```ruby
puts("Hello")    # Hello\n (Adiciona quebra de linha no final do texto)
print("World")   # World
```

### Numbers operators and methods

```ruby
# Operadores aritméticos: +, -, *, / e %
3 ** 2      # Exponenciação
10 % 3      # Resto da divisão
10 / 3.0    # Resultado: 3.333 (Float)
10 / 3      # Resultado: 3 (Integer)

# Operadores de atribuição: =, +=, -=, *=, /= e %=
num = 10
num += 100  # Resultado: 110

# Métodos
-10.abs()       # 10 (+)
36.6.round()    # 37

# Classe Math
Math.sqrt(100)  # 10
Math.log(0)     # -Infinity
```

### User Input

```ruby
name = gets()         # Espera pelo input do usuário. Armazena o "enter" após o input
name = gets.chomp()   # Não armazena o "enter" ao finalizar o input
```

### Arrays

São coleções ordenadas e indexadas por inteiros de qualquer objeto. São objetos da classe Array.

```ruby
# Criando
array_a = [9, 8.1, true, "cinco"]
array_b = Array[]
array_b = Array.new()
array_b = Array.new(3)          # Saída:  [nil, nil, nil]
array_b = Array.new(3, "A")     # Saída:  ["A", "A", "A"]
array_c = %w("Cada palavra se torna um elemento indexado")

# Adicionando e modificando
array_a[4] = "seis"
array_a[4] = "dez"
array_a.push(0)

# Acessando
array_a[0]            # 9
array_a.at(1)         # 8.1
array_a[-1]           # dez
array_a[1, 3]         # [8.1, true, "cinco"] (start, count)
array_a[1..3]         # [8.1, true, "cinco"] (start..end)
```

#### 2d Arrays

```ruby
my_grid = [[1, 2], [3, 4]]

my_grid[0][0] = 5

puts my_grid[0][0]  # Saída: 5
puts my_grid[0][1]  # Saída: 2
```

#### Principais métodos

- +: Concatenação de arrays
- -: Diferença de arrays
- <<: Adiciona um objeto ao final do array (append)
- <=>: Comparação de arrays
- ==: Verifica se dois arrays têm o mesmo comprimento e conteúdo
- clear: Remove todos os elementos do array
- compact: Retorna uma cópia do array com todos os elementos nil removidos
- compact!: Remove os elementos nil do array original
- delete: Remove todas as ocorrências de um determinado valor do array
- delete_at: Remove o elemento em um determinado índice
- each: Itera sobre cada elemento do array, passando-o para o bloco (Enumerable)
- empty?: Retorna true se o array estiver vazio
- flatten: Retorna um novo array que é uma versão unidimensional do array original (recursivamente)
- flatten!: Modifica o array original para ser uma versão unidimensional
- include?: Retorna true se o array contém um determinado objeto
- join: Concatena todos os elementos em uma string, separados por um separador opcional
- length, size: Retorna o número de elementos no array
- push: Adiciona um ou mais elementos ao final do array
- pop: Remove e retorna o último elemento do array
- shift: Remove e retorna o primeiro elemento do array
- slice!: Remove e retorna o elemento ou subarray especificado
- sort: Retorna um novo array com os elementos ordenados
- sort!: Ordena os elementos no array original
- uniq: Retorna um novo array com valores duplicados removidos
- uniq!: Remove valores duplicados do array original

### Methods

Um método pode retornar um valor implicitamente (o resultado da última expressão avaliada) ou explicitamente usando a palavra-chave return. Ou seja, ele **sempre** retorna algo.

Existem convenções de nomenclatura para tipos específicos de métodos:

- Predicate methods (?): Métodos que atuam como consultas geralmente terminam com um ponto de interrogação, retornam um valor booleano
- Bang methods (!): Métodos que podem modificar o objeto receptor frequentemente terminam com um ponto de exclamação, geralmente têm uma versão correspondente sem o "!" que retorna uma nova cópia modificada do objeto

```ruby
# num2=100 define um valor padrão caso não tenha argumento
def add_numbers(num1, num2=100)
    # return num1 + num2
    num1 + num2             # Retorno implícito
end

puts add_numbers(5, 10)     # Saída: 15
puts add_numbers(5)         # Saída: 105
```

#### Diferentes formas de chamar métodos

Em Ruby, a invocação de métodos e a definição de seus parâmetros oferecem flexibilidade. Veja as diferentes formas.

Invocação de Métodos:

- Com parênteses
- Sem parênteses

Definição de Parâmetros em Métodos:

- Parâmetros regulares: São definidos dentro dos parênteses após o nome do método na definição
- Parâmetros com valores padrão: Você pode definir valores padrão para os parâmetros. Se um argumento não for fornecido na chamada do método, o valor padrão será usado
- Parâmetros variáveis (Array parameter): Um parâmetro precedido por um asterisco \* permite que o método receba um número variável de argumentos, que serão agrupados em um array
- Parâmetro de bloco (Block parameter): Um método pode receber um bloco de código como um argumento implícito (usando yield dentro do método) ou explícito (usando &nome_do_bloco na definição do método)

```ruby
# Criando métodos
def regular(x, y)
  x + y
end

def no_param
  puts "Hello world"
end

def default_value(x, y = 10)
  x + y
end

def args_param(*args)
  sum = 0
  args.each { |num| sum += num }
  return sum
end

def block_param(&block)
  my_var = "Bloco executado com sucesso!"

  # Forma explícita
  if block
    puts "Executando bloco..."
    block.call my_var
  else
    puts "Nenhum bloco de código foi encontrado"
  end

  # Forma implícita
  # yield my_var
  # yield my_var if block_given?   # Executa o bloco caso seja encontrado. "block_given?" é um helper
end

# Invocando método
# OBS: Em Ruby, os parênteses são geralmente opcionais na chamada de métodos. É importante notar que, em casos mais complexos, o uso de parênteses pode ajudar a evitar ambiguidades e tornar o código mais legível

regular(1, 2)           # Saída: 3
regular 1, 2            # Saída: 3

no_param()              # Saída: "Hello world"
no_param                # Saída: "Hello world"

default_value(1)        # Saída: 11
default_value 1         # Saída: 11
default_value(1, 2)     # Saída: 3
default_value 1, 2      # Saída: 3

args_param(1, 2, 3)     # Saída: 6
args_param 1, 2         # Saída: 3

block_param { |black_method_var| puts black_method_var }
block_param do
  texto = "Bloco executado com sucesso"
  puts texto
end
```

### If Statements

> Em Ruby, **apenas** _nil_ e _false_ são considerados valores falsos (falsy). Todos os outros valores são considerados verdadeiros (truthy), incluindo a string "", o número 0, um array vazio [] e um hash vazio {}.

```ruby
# Operadores lógicos: && (and), || (or) e ! (not)
# Operadores relacionais: ==, !=, >, <, >= e <=

# if...else statement
if expressão_a_ser_avaliada == true and 1 < 2
  # code
elsif true or false
  # code
elsif true and not false
  # code
else
  # code
end

# if modifier (code if condition)
puts "Hello, world!" if true
```

Importante notar que _if_ em Ruby **é uma expressão**, não apenas uma statement, o que significa que ela retorna um valor. O valor retornado é o valor da última expressão avaliada dentro do bloco de código que foi executado.

```ruby
artist = "Eminem"
handle = if artist == "Gillespie"
          "Dizzy"
        elsif artist == "Parker"
          "Bird"
        else
          "unknown"
        end

puts handle   # Saída: "unknown"
```

### Unless Statement

Executa código se a condição for falsa. Se a condição for verdadeira, o código especificado na cláusula else será executado.

```ruby
unless false
   # code
else
   # code
end

# unless modifier (code unless false condition)
puts "Hello, world!" unless false
```

### Ternary Operator

Uma forma concisa de escrever uma if...else statement em uma única linha.

```ruby
# condição ? <executar se verdadeiro> : <executar se falso>

puts 1 < 2 ? "a" : "b"  # Saída: "a"
```

### Switch Statements

Assim como as if statements, case é uma expressão e retorna um valor.

> NOTA: Cada expressão é comparada com o operador de igualdade de caso (===).
> **Não** há necessidade de colocar a palavra-chave "break" no final de cada "when" como nas outras linguagens de programação.

```ruby
case "A"
    when "A"
      # code
    when "B"
      # code
    when "C"
      # code
    else        # Cláusula padrão caso não tenha correspondência
      # code
end
```

### Dictionaries

```ruby
# Relação chave/valor
my_dictionary = {
  "Andy" => "A",    # (key) String
  :Stanley => "B",  # (key) Symbol
  is_true: false,   # (key) Symbol
  3 => 10.0,        # (key) Integer
}

# Acessando
my_dictionary["Andy"]
my_dictionary[:Stanley]
my_dictionary[:is_true]
my_dictionary[3]            # 3 é a chave e não o index

puts my_dictionary # Saída: {"Andy" => "A", :Stanley => "B", :is_true => false, 3 => 10.0}
```

### While Loops

```ruby
=begin
  while true
    # code
  end
=end

index = 1

while index <= 5
  puts index
  index += 1
end
```

### For Loops

```ruby
for index in 0..5
  puts index
end

5.times do |index|
  puts index
end

lucky_nums = [1, 2, 3, 4, 5]
for lucky_num in lucky_nums
  puts lucky_num
end

lucky_nums.each do |lucky_num|
  puts lucky_num
end
```

### Exception Catching

```ruby
begin
  # Código que pode lançar algum erro
rescue OneTypeOfException
  # Código a ser executado caso a exceção seja lançada
rescue AnotherTypeOfException => error_variable
  # Código a ser executado caso a exceção seja lançada
rescue # Exceção genérica
  # Código a ser executado caso ocorra qualquer outra exceção
ensure
  # Código que SEMPRE será executado
end

# Lança um 'RuntimeError' com a mensagem "Porque sim"
raise "Porque sim"
```

### Classes & Objects

```ruby
class Book
  # Helper que cria getters e setter para os atributos da classe
  attr_accessor :title, :author

  # Método construtor da classe
  def initialize(title, author)
    # @ sinaliza que a variável é uma 'Variável de instância' assim como 'self.*'
    @title = title
    self.author = author
  end

  def readBook()
    puts "Reading #{self.title} by #{self.author}"
  end

  # Criando getter e setter *manualmente*
  # setter
  def title=(title)
    @title = title
  end

  # getter
  def title
    @title
  end
end

book1 = Book.new("Harry Potter", "JK Rowling")
# book1.title = "Harry Potter"
# book1.author = "JK Rowling"
book1.readBook      # Saída: "Reading Harry Potter by JK Rowling"

puts book1.title    # Saída: "Harry Potter"
```

#### Inheritance (Herança)

```ruby
class Person
  attr_accessor :name

  def initialize(name)
    @name = name
  end

  def run
    puts "My top speed is 20km/h"
  end
end

# '<' atribui 'Person' como superclasse de 'Athlete'
class Athlete < Person
  attr_accessor :sport

  def initialize(name, sport)
    @sport = sport
    super(name)     # Encaminha os parâmetros para a superclasse
  end

  # Polymorphism usando herança
  def run
    puts "My top speed is 40km/h"
  end
end

person1 = Person.new("John Doe")
person1.run

athlete1 = Athlete.new("Doe Jhon", "Soccer")
puts athlete1.name  # Saída: "Doe Jhon"
athlete1.run

```

## Parênteses, Colchetes e Chaves

Em Ruby, **parênteses** é opcional, inclusive no momento de criar o método.

**Colchetes** são utilizados para criar/acessar arrays.

**Chaves** são utilizadas para criar hashs e closures (blocos). Também é utilizado para substituir o _do...end_ quando ele é apenas uma única linha.

## Array e Hash

> TODO: Remover

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

Métodos são blocos de código que realizam uma tarefa específica e podem ser reutilizados em diferentes partes de um programa.

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

## Recebendo blocks como argumento

### yield

A palavra-chave yield para a execução do método e passa o controle para o bloco que foi passado como parâmetro pelo método. Na prática, serve para inserir blocos de código dentro dum método.

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

### Self

> Em Ruby, a palavra-chave _self_ tem um funcionamento semelhante ao **this** em outras linguagens de programação. Porém, pode se referir tanto à instância quanto à classe.

Self é uma palavra reservada que dá acesso ao objeto corrente. Por exemplo, ao instanciar uma classe chamada Pessoa através da variável _ps_, estou acessando a classe (objeto corrente) através dessa variável.

Quando utilizamos o _self_ fora duma classe, acessamos o _namespace_ global que é o **main**.

```ruby
puts self   # Saída: main

class Pessoa
    # Helper que gera o getter e setter
    attr_accessor :nome

    # Método construtor
    def initialize(nom)
        self.nome = nome    # Self refere-se à instância atual
    end

    def saudacao
        puts "Olá, meuy nome é ${self.nome}"
    end

    def self.natureza
        puts "Método de classe"
    end
end

Pessoa.natureza # Saída: "Método de classe"
ps = Pessoa.new("João")
ps.saudacao       # Saída: "Olá, meuy nome é João"
```

#### Variáveis de instância

Em Ruby, o '@' (ou self) antes do nome de uma variável indica que ela é uma variável de instância. Variáveis de instância são associadas a uma instância de uma classe e podem ser acessadas em qualquer método dessa instância. Elas são privadas, ou seja, requer getter e setter para ser acessada fora da classe.

```ruby
class Pessoa
    # Helper gerador de getter/setter
    attr_accessor :idade

    # Método construtor (construct)
    def initialize(nome, idade)
        @nome = nome
        self.idade = idade
    end

    # Getter para @nome
    def nome
        @nome
    end

    # Setter para @nome
    # Atenção à sintaxe
    def nome=(novo_nome)
        @nome = novo_nome
    end

  def apresentar
    puts "Olá, meu nome é #{@nome} e tenho #{idade} anos."
  end
end

pessoa = Pessoa.new("João", 30)
pessoa.apresentar  # Saída: "Olá, meu nome é João e tenho 30 anos."

pessoa.nome = "John"
puts pessoa.nome
```

### Variáveis de classe

Pertencem à classe como um todo e são compartilhadas por todas as instâncias da classe.

> Em Java, por exemplo, seriam métodos estáticos.

```ruby
class Pessoa
  @@contador = 0  # Variável de classe

  def initialize(nome)
    @nome = nome  # Variável de instância
    @@contador += 1
  end

  def self.contador
    @@contador
  end
end

pessoa1 = Pessoa.new("João")
pessoa2 = Pessoa.new("Maria")

puts Pessoa.contador  # Saída: 2
```

### Variável global

> TODO: $my_var

### Monkey Patch

> Afeta todas as instâncias da classe.

Permite o desenvolvedor a modificar uma classe já existente em momento de execução através das seguintes formas:

- Criando um novo método
- Sobreescrevendo um método existente

> Também é possível modificar uma classe com o método **class_eval**. Para modificar métodos de um objeto, utilize **instance_eval**.

```ruby
# Criando
class String
    def novo_metodo
        puts "Sou um novo método!"
    end
end

"teste".novo_metodo # Saída: "Sou um novo método!"

# Sobreescrita
class String
    def novo_metodo
        puts "Olá ${self}"
    end
end

"teste".novo_metodo # Saída: "Olá teste"
```

## Módulo

Módulo é uma coleção de métodos e constantes. É possível adicionar um módulo à uma classe com **include** ou **require**.

Quando você _inclui_ um módulo em uma classe, os métodos do módulo se tornam métodos de _instância da classe_. Quando você _estende_ um módulo em uma classe, os métodos do módulo se tornam _métodos de classe_.

Se o módulo define métodos como _métodos de módulo_ (usando **self**), você pode chamá-los diretamente usando o operador de resolução de escopo (::) ou ponto (.).

> NOTA: É uma convenção utilizar SCREAMING_SNAKE_CASE no nome das constantes.

```ruby
# Criando módulo
module Sobre
    LINGUAGEM_UTILIZADA = "Ruby"
    VERSAO = "3.1.1"

    def somar(x, y)
        x + y
    end

    def self.subtrair(x, y)
        x - y
    end
end

# Acessando módulo
Sobre::VERSAO           # Saída: "3.1.1"
Sobre.subtrair(2, 1)    # Saída: 1
Sobre::subtrair(3, 1)   # Saída: 2
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
    extend Email
end

# Utilizando Mixin
mixin = MeuMixin.new
mixin.calcular

MeuMixin.enviar_email
```

## Singleton Pattern x Singleton Class

Singleton Pattern é um padrão de projeto (_Design Pattern_) que garante a _existência de apenas uma instância de uma classe_ mantendo um ponto global de acesso ao seu objeto.

Em Ruby, o padrão Singleton _parece_ uma classe estática. É comumente utilizado em classes que instanciam Banco de Dados e geram Logs.

```ruby
require "singleton"

class Foobar
    include Singleton

    def oi
        puts "Oi"
    end
end

foo = Foobar.new    # ERROR!
Foobar.instance.oi  # Saída: "Oi"
```

Singleton Class (também chamada de Eigenclass ou Metaclass) é uma classe especial que é criada automaticamente para um objeto específico. Essa classe é usada para armazenar métodos que são exclusivos para aquele objeto, ou seja, métodos que não são compartilhados com outras instâncias da mesma classe.

É a mesma coisa que realizar o _object.instance_eval do_.

> Ruby Object Model

```ruby
class Teste
    def oi
        puts "Oi"
    end
end

x = Teste.new
y = Teste.new

x.oi    # Saída: "Oi"
y.oi    # Saída: "Oi"

# Adicionando um método à Singleton Class do objeto y
class << y
    def hello
        puts "Hello"
    end
end

x.hello # ERROR!
y.hello # Saída: "Hello"
```

## Symbols x Strings

Simbolo é todo objeto iniciado por dois pontos (:) seguido por uma palavra qualquer. Texto é uma string contida entre aspas simples ou duplas.

O método **\*.object_id** retorna o _id_ único do objeto, inclusive strings e inteiros. Por mais que o _conteúdo_ da string, por exemplo, seja o mesmo, o object*id será diferente. Porém, o **object_id** de um \_symbol* será o mesmo. Ou seja, a string é repetida na memória quando declarada com o mesmo conteúdo, mas o symbol não.

> OBS: Symbols que requerem caracteres especiais (inclusive espaços), utilize aspas. Ex.: :'pt-BR'

```ruby
# Symbol
:my_text.class      # Saída: String
:my_text.object_id # Saída: 984808
:my_text.object_id # Saída: 984808
:my_text.object_id # Saída: 984808

# Texto
"my_text".class     # Saída: Symbol
"my_text".object_id # Saída: 835345435
"my_text".object_id # Saída: 825124463
"my_text".object_id # Saída: 865434534
```

## Gemas

> TODO

## Como instalar

> TODO

# Ruby

> Versão de estudo: 3.1.1 ([Documentação](https://ruby-doc.org/core-3.1.1/))

## História

Foi publicada em 1995 por Yukihiro Matsumoto ("Matz") no Japão. Ela combina ideias de várias linguagens como Perl, Smalltalk, Eiffel, Ada e Lisp, e é conhecida por sua sintaxe legível e elegante.

Inicialmente, Ruby não era uma linguagem bem documentada, pois Matz preferia escrever programas a documentação. Ele expressa a sua gratidão a Dave Thomas e Andy Hunt, autores do livro "Programming Ruby" (também conhecido como "PickAxe"), por terem apresentado Ruby em grande escala fora do Japão.

## Características

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

> Temas como variáveis de instância, variáveis de classe e variável global serão abortados mais à frente.

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

#### Symbols x Strings

_Symbol_ é todo objeto prefixado por dois pontos (:) e seguido por uma palavra qualquer.

O método **\*.object_id** retorna o _id_ único do objeto, inclusive de strings e inteiros. Por mais que o conteúdo da string seja o mesmo, o object_id será **diferente**. Porém, o object_id de um symbol será o **mesmo**. Ou seja, a string é repetida na memória quando declarada com o mesmo conteúdo, mas o symbol não.

> OBS: Utilize aspas para symbols que requerem caracteres especiais (inclusive espaços). Ex.: :'pt-BR' e :'symbol com espaço'

```ruby
# Symbol
:my_text.class          # Saída: Symbol
:my_text.object_id      # Saída: 984808
:my_text.object_id      # Saída: 984808
:my_text.object_id      # Saída: 984808

# String
"my_text".class         # Saída: String
"my_text".object_id     # Saída: 765434533
"my_text".object_id     # Saída: 835345434
"my_text".object_id     # Saída: 925124465
```

#### Range

Um range (intervalo) representa uma sequência de valores ou um intervalo, você pode pensar neles como listas ordenadas. Tem um ponto de início e um ponto de fim. Eles podem ser criados usando literais `..` e `...` ou o método `Range.new`.

```ruby
# O formato de dois pontos (..) cria um range *inclusivo*, significando que o ponto de fim está incluído na sequência
# O formato de três pontos (...) cria um range *exclusivo*, significando que o ponto de fim é excluído da sequência

(1..3).to_a         # Saída: [1, 2, 3]
(1...3).to_a        # Saída: [1, 2]
('a'..'d').to_a     # Saida: ["a", "b", "c", "d"]

# Casos de uso
age = 18
puts "Maior de idade" if (18..100).include?(age)

(1..5).each do |n|
  puts "Número: #{n}"
end
```

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

### Constants

Uma constante em Ruby é qualquer nome de variável que **começa com letra maiúscula**. Permite **reatribuição**, mas exibe um warning.

É recomendado o uso do "SCREAMING_SNAKE_CASE" para nomear constantes.

```ruby
PI = 3.14159
puts PI               # Saída: 3.14159

PI = "Hello world"    # warning: already initialized constant PI
puts PI               # Saída: "Hello world"
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
puts("Hel" + "lo")    # Hello\n (Adiciona quebra de linha no final do texto)
print("World")        # World
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
- ==: Verifica se dois arrays têm o mesmo comprimento e conteúdo
- clear: Remove todos os elementos do array
- compact: Retorna uma cópia do array com todos os elementos nil removidos
- delete: Remove todas as ocorrências de um determinado valor do array
- delete_at: Remove o elemento em um determinado índice
- each: Itera sobre cada elemento do array, passando-o para o bloco (Enumerable)
- empty?: Retorna true se o array estiver vazio
- flatten: Retorna um novo array que é uma versão unidimensional do array original (recursivamente)
- include?: Retorna true se o array contém um determinado objeto
- join: Concatena todos os elementos em uma string, separados por um separador opcional
- length, size: Retorna o número de elementos no array
- push: Adiciona um ou mais elementos ao final do array
- pop: Remove e retorna o último elemento do array
- shift: Remove e retorna o primeiro elemento do array
- slice!: Remove e retorna o elemento ou subarray especificado
- sort: Retorna um novo array com os elementos ordenados
- uniq: Retorna um novo array com valores duplicados removidos

### Hashes

Coleções Indexadas Semelhante aos arrays, hashes são coleções indexadas de referências a objetos. No entanto, a diferença fundamental é o tipo de chave usada para indexação. Enquanto arrays usam números inteiros como chave, hashes podem usar qualquer objeto como chave. Também são conhecidos por outros nomes em programação, como "Dictionaries", "associative arrays" ou "maps".

> Embora qualquer objeto possa ser uma chave, há uma preferência por usar **Symbols** como chaves de hash.

```ruby
# Relação chave/valor
my_hash = {
  "Andy" => "A",    # (key) String
  :Stanley => "B",  # (key) Symbol
  is_true: false,   # (key) Symbol
  3 => 10.0,        # (key) Integer
  other_hash: {     # (key) Symbol
    foo: "bar"
  }
}

# Acessando
my_hash["Andy"]
my_hash[:Stanley]
my_hash[:is_true]
my_hash[3]            # 3 é a chave e *não o index*

puts my_hash # Saída: {"Andy" => "A", :Stanley => "B", :is_true => false, 3 => 10.0}

# Métodos exclusivos
my_hash.keys      # Saída: ["Andy", :Stanley, :is_true, 3, :other_hash]
my_hash.values    # Saída: ["A", "B", false, 10.0, {:foo=>"bar"}]
```

### Methods

Um método pode retornar um valor implicitamente (o resultado da última expressão avaliada) ou explicitamente usando a palavra-chave return. Ou seja, ele **sempre** retorna algo.

Existem convenções de nomenclatura para tipos específicos de métodos:

- Predicate methods (?): Métodos que atuam como consultas geralmente terminam com um ponto de interrogação, retornam um valor booleano
- Bang methods (!): Métodos que podem modificar o objeto receptor frequentemente terminam com um ponto de exclamação, geralmente têm uma versão correspondente sem o "!" que retorna uma nova cópia modificada do objeto

> Conteúdo sobre _blocks_, _procs_ e _lambda_ mais à frente.

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

Em Ruby, a invocação de métodos e a definição de seus parâmetros oferecem flexibilidade.

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
  yield my_var
  yield my_var if block_given?   # Executa o bloco caso seja encontrado. "block_given?" é um helper
end

# Invocando método
# OBS: Em Ruby, os parênteses são geralmente opcionais na chamada de métodos.
# É importante notar que, em casos mais complexos, o uso de parênteses pode ajudar a evitar ambiguidades e tornar o código mais legível

regular(1, 2)           # Saída: 3
regular 1, 2            # Saída: 3

no_param()              # Saída: "Hello world"
no_param                # Saída: "Hello world"

default_value(1)        # Saída: 11
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

> Em Ruby, **apenas** _nil_ e _false_ são considerados valores falsos (falsy). Todos os outros valores são considerados verdadeiros (truthy), incluindo uma string vazia "", o número 0, um array vazio [ ] e um hash vazio { }.

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

### While Loop

Variáveis locais existentes podem ser usadas dentro do loop, e quaisquer novas variáveis locais criadas dentro do corpo do loop estarão **disponíveis após a sua execução**.

Palavras-chave que permitem alterar o fluxo normal através de um loop while:

- break: Encerra o loop imediatamente
- next: Pula para o final da iteração atual, começando efetivamente a próxima iteração
- redo: Repete a iteração do loop desde o início, mas sem reavaliar a condição
- retry: Reinicia o loop, reavaliando a condição

> TODO: Pesquisar sobre "Uso de Ranges em condições booleanas".

```ruby
# OBS: "do" é opcional
num = 1

while num <= 5 do
  num += 1
  foo = "bar"   # Declarando variável dentro do loop while
end

puts foo    # Saída: "bar"
```

### Until Loop

O loop until é o oposto do loop while. Ele continua enquanto a condição for falsa.

Loops while e until podem ser usados de forma praticamente intercambiável. A escolha entre eles geralmente depende de qual condição de parada torna o código mais legível.

```ruby
num = 1

until num > 5
  num += 1
end

# until de uma linha (modificador)
count = 0
puts count += 1 until count == 5
```

### Loop do

É uma construção de **loop infinito**, usada quando você quer executar algo continuamente até usar um `break` **explicitamente**.

```ruby
i = 0

loop do
  i += 1
  break if i > 5
end
```

### For Loop

Um loop for é uma estrutura de loop utilizada para **iterar através de uma coleção de informações**, como um array ou um range.

> Executa o corpo do loop uma vez para cada elemento na expressão fornecida (coleção).
> `break`, `redo`, `next` e `retry` são palavras-chave de controle de fluxo que podem ser utilizadas.

```ruby
for num in 0..5
  puts num
end

5.times do |num|
  puts num
end

lucky_nums = [1, 2, 3, 4, 5]
for lucky_num in lucky_nums
  puts lucky_num
end
```

#### For Loop X Each

A única diferença entre um `for loop` e sua forma equivalente `each`, está no **escopo das variáveis locais**.

Os loops for são estruturas embutidas na linguagem e não introduzem um novo escopo. Isso significa que variáveis locais existentes antes do loop for podem ser usadas dentro dele, e quaisquer novas variáveis locais criadas dentro do corpo do loop for estarão disponíveis após a sua a sua execução.

Isso contrasta com os blocos (como aqueles usados com `each`), onde as variáveis locais criadas dentro do bloco geralmente **não** são acessíveis fora do bloco

```ruby
lucky_nums = [1, 2, 3, 4, 5]

lucky_nums.each do |lucky_num|
  puts lucky_num
end
```

## Exception Catching

O mecanismo principal para capturar exceções em Ruby é a estrutura `begin`, `rescue` e `end`.

Ao levantar uma exceção, Ruby compara-a com os parâmetros de cada cláusula `rescue` por sua vez.
A comparação `(===)` tem sucesso se a exceção levantada é da **mesma classe** que o parâmetro **ou uma subclasse** dele.

Uma cláusula `rescue` sem parâmetros é tratada como se tivesse um parâmetro `StandardError`. Portanto, ela captura StandardError e suas subclasses. Para capturar **qualquer exceção** (incluindo aquelas que não herdam de StandardError), você deve usar `Exception`.

> A palavra-chave `retry` dentro de uma cláusula rescue **reinicia** o bloco begin/end. CUIDADO com loop infinito!

```ruby
begin
  # Código que pode lançar uma exceção
rescue OneTypeOfException
  # Código a ser executado caso a exceção especificada seja lançada
rescue AnotherTypeOfException => error_variable
  # Código a ser executado caso a exceção especificada seja lançada
rescue # Exceção genérica (StandardError)
  # Código a ser executado caso ocorra qualquer outra exceção
else
  # Código a ser executado somente se nenhuma exceção foi lançada
ensure
  # Código que SEMPRE será executado
end

# Lança um 'RuntimeError' com a mensagem "Minha mensagem de erro"
raise "Minha mensagem de erro"
```

## Classes e Objetos

Em Ruby, **tudo** o que você manipula é um objeto. Isso inclui até mesmo tipos de dados básicos como strings, números e os valores booleanos.

A própria classe em Ruby é um objeto, sendo uma instância da classe `Class`. A classe `Object` é a classe pai de todas as outras classes.

Os nomes de classes e módulos devem, por convenção, seguir o padrão **CamelCase**.

```ruby
class Book
  # Helper que cria getter para os atributos
  # attr_reader :title, :author

  # Helper que cria setter para os atributos
  # attr_writer :title, :author

  # Helper que cria getters e setter para os atributos
  attr_accessor :title, :author

  # Definindo constante
  VERSION = "1.0.0"

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

  # Define um escopo privado (Encapsulamento)
  private

  def hello # Não é acessível fora da classe
    puts "world"
  end
end

book1 = Book.new("Harry Potter", "JK Rowling")
# book1.title = "Harry Potter"
# book1.author = "JK Rowling"
book1.readBook      # Saída: "Reading Harry Potter by JK Rowling"
puts book1.title    # Saída: "Harry Potter"

# Acessando constante de classe com (::)
puts Book::VERSION
```

### Herança e Polimorfismo

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

  # Polimorfismo
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

### Variáveis de instância

> As variáveis de instância são **privadas** para o objeto.

### Variáveis de classe

Pertencem à classe como um todo e são compartilhadas por todas as instâncias da classe.

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

### Variáveis global

> TODO

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

## Catch/Throw

> TODO

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

### Mixin

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

## Variáveis especiais (Global Magic Variables)

> TODO

## Gems

> TODO

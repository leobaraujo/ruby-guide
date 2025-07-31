TODO:

- [ ] Revisão e adição de imagens
- [ ] Reestruturação da ordem do conteúdo
- [ ] Adição de "Table of Contents"
- [ ] Projetos
- [ ] Busca por novas informações
  - [ ] Simbolo como atalho em iterações
  - [ ] Adicionar lista de "helpers"

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

> OBS: É possível adicionar arquivos ruby dentro do ambiente IRB. Por exemplo, se o IRB estiver sendo executado na pasta _/my_app_ que contém o arquivo _my_code.rb_, ao executar a instrução `require_relative 'my_code'` o conteúdo de _my_code_ será carregado no ambiente IRB.

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

print(`clear`)        # Limpa o terminal
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
- inject: Similar ao "reduce()" em outras linguagens de programação. Acumula um valor ao iterar sobre os elementos, aplicando um bloco de operação entre o acumulador e cada elemento
- empty?: Retorna true se o array estiver vazio
- flatten: Retorna um novo array que é uma versão unidimensional do array original (recursivamente)
- include?: Retorna true se o array contém um determinado objeto
- join: Concatena todos os elementos em uma string, separados por um separador opcional
- size: Retorna o número de elementos no array
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
- Parâmetro de bloco (Block parameter): Um método pode receber um bloco de código como um argumento **implícito** (usando yield dentro do método) ou explícito (usando &nome_do_bloco na definição do método)

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

# OBS: Sobrecarga de métodos
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
  # OBS: Não requer a definição do parâmetro &block
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
if expressão_avaliada == true and 1 < 2
  # code
elsif true or false
  # code
elsif true and not false
  # code
else
  exit 0    # Encerra a execução do processo. 0 = sem erro, 1 = saída com erro
end

# if modifier (code if condition)
puts "Hello, world!" if true

# 'then' é uma palavra-chave reservada e *opcional*
if 1 > 2 then puts "False"
elsif 2 > 1 then puts "True"
else puts "Hello, world"
end
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

Similar ao **do while loop** noutras linguagens de programação.

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
# Array
lucky_nums = [1, 2, 3, 4, 5]

for lucky_num in lucky_nums
  puts lucky_num
end

# Hash
person = { name: "John Doe", age: 20, genre: "M" }

for key, value in person
  puts "#{key}: #{value}"
end

# Range
for num in 0..5
  puts num
end
```

### Times

O laço de repetição _times_ em Ruby é um método da classe `Integer`, usado para executar um bloco de código um **número específico de vezes**. Ele é ideal quando se sabe de antemão quantas repetições são necessárias.

> OBS: Começa pelo índice zero (0).

```ruby
# Integer
5.times do |num|
  puts num
end
```

### For Loop X Each

A única diferença entre um `for loop` e sua forma equivalente `each`, está no **escopo das variáveis locais**.

Os loops for são estruturas embutidas na linguagem e não introduzem um novo escopo. Isso significa que variáveis locais existentes antes do loop for podem ser usadas dentro dele, e quaisquer novas variáveis locais criadas dentro do corpo do loop for estarão disponíveis após a sua a sua execução.

Isso contrasta com os blocos (como aqueles usados com `each`), onde as variáveis locais criadas dentro do bloco geralmente **não** são acessíveis fora do bloco.

> Operações realizadas dentro do bloco each **não** modificam a coleção original a menos que você use métodos destrutivos (com `!`).

```ruby
# Array
lucky_nums = [1, 2, 3, 4, 5]

lucky_nums.each do |lucky_num|
  puts lucky_num
end

# Hash
person = { name: "John Doe", age: 20, genre: "M" }

person.each do |key, value|
  puts "#{key}: #{value}"
end
```

### Each X Map (Collect)

O método `each` é fundamental para iterar sobre cada elemento de uma coleção e executar um bloco de código para cada um deles. Ele é usado quando você precisa realizar uma ação ou um efeito colateral (como imprimir valores, atualizar um banco de dados, etc.) para cada item.

O método `map` (também chamado de `collect`) é projetado especificamente para transformar cada elemento de uma coleção e **retornar uma nova coleção** (um novo array) contendo os resultados dessas transformações.

#### Efeito colateral (Side effect)

É qualquer alteração fora do escopo de uma função ou expressão. São essencialmente diferentes de **funções puras**, que não têm efeitos colaterais, são previsíveis: dado o mesmo input, sempre retornam o mesmo output e não afetam nada mais no sistema.

Exemplos de efeitos colaterais comuns:

- Modificar uma variável global ou externa.
- Alterar o conteúdo de uma estrutura de dados passada por referência.
- Escrever em arquivos ou no banco de dados.
- Imprimir no console (como _puts_ em Ruby).
- Fazer chamadas de rede (API).

```ruby
# Função com efeito colateral
def adicionar_nome(lista, nome)
  lista << nome   # Modifica a lista original (efeito colateral)
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
class Person
  # Por padrão, todos os atributos de classe são privado
  @name
end

p = Person.new
p.name = "Fulano"   # Error: Undefined method 'name='

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
    puts "Reading #{self.title} by #{@author}"
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

> Ruby não suporta herança múltipla diretamente (Conteúdo sobre "mixin" mais adiante.).

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
    # super         # Também é possível chamar o método "super" noutro método que a classe pai tenha
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

Armazena dados **específicos do objeto** e só pode ser acessada dentro da instância onde foi definida. Requer _getter_ e _setter_ uma vez que são **privados**.

```ruby
# Exemplo completo logo a cima na classe "Book"
def initialize(title, author)
  # @ sinaliza que a variável é uma 'Variável de instância' assim como 'self'
  @title = title
  self.author = author
end
```

### Variáveis de classe

Variáveis de classe em Ruby começam com `@@` e são **compartilhadas entre todas as instâncias** da mesma classe mantendo um valor comum.

```ruby
class Pessoa
  @@contador = 0  # Variável de classe

  def initialize(nome)
    @nome = nome  # Variável de instância
    @@contador += 1
  end

  # 'self.' determina que o método será acessível somente pela classe e não pelo objeto
  def self.modelo_contador
    @@contador
  end

  def instancia_contador
    @@contador
  end
end

pessoa1 = Pessoa.new("João")
pessoa2 = Pessoa.new("Maria")

puts pessoa1.instancia_contador     # Saída: 2
puts pessoa2::instancia_contador    # Saída: 2

# Também pode ser acessível com (::)
puts Pessoa.modelo_contador         # Saída: 2
puts Pessoa::modelo_contador        # Saída: 2
```

### Variáveis global

Começam com `$` e podem ser acessadas e modificadas de qualquer lugar do programa.

> Podem ser compartilhadas entre diferentes arquivos e módulos, classes, etc., desde que o código esteja sendo executado no mesmo processo.

```ruby
$mensagem = "Olá, mundo!"
foo = "Bar"

class Saudacao
  def mostrar_global
    puts $mensagem
  end

  def mostar_nao_global
    puts foo
  end
end

saudacao = Saudacao.new
saudacao.mostrar_global       # Saída: "Olá, mundo!"
saudacao.mostar_nao_global    # Error: NameError (undefined local variable or method)
```

### Monkey Patch

Permite o desenvolvedor a modificar uma classe **já existente** em momento de execução adicionando ou sobreescrevendo métodos.

Comumente utilizado para:

- Adicionar funcionalidades a classes que você não criou
- Corrigir ou sobrescrever comportamentos de bibliotecas
- Estender classes de forma rápida

> OBS: Pode quebrar atualizações futuras de gems ou do Ruby.

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

### class_eval e instance_eval

Ambos `class_eval` e `instance_eval` são variações do método `eval`. O método eval permite analisar e executar uma string cujo conteúdo é código Ruby legal. Um objeto `Binding` pode ser usado **opcionalmente** para especificar o ambiente de avaliação, encapsulando variáveis, métodos, o valor de `self`.

Diferenças:

- `instance_eval`: Encontrado na classe `Object`, permite que você avalie uma string contendo código fonte Ruby ou um bloco de código dentro do contexto do objeto receptor
- `class_eval`: Encontrado na classe `Module`, permite que você avalie uma string ou um bloco de código no **contexto de um módulo**.

> Utilizado em _metaprogramação_.

```ruby
# Exemplo 1: Acessando variável de instância sem método setter/getter
class Pessoa
  def initialize(nome)
    @nome = nome
  end
end

p = Pessoa.new("João")
p.instance_eval do
 @nome = "Joaquim"
end
puts p.instance_eval { @nome }  # Saída: "Joaquim"

# Exemplo 2: Definir métodos dinamicamente em um objeto específico
obj = Object.new

obj.instance_eval do
  def saudacao
    "Olá, mundo!"
  end
end

puts obj.saudacao  # Saída: "Olá, mundo!"
```

```ruby
# Exemplo 1: Adicionando método a uma classe existente
class Pessoa; end

Pessoa.class_eval do
  def saudacao
    "Olá!"
  end
end

p1 = Pessoa.new
p2 = Pessoa.new

puts p1.saudacao       # Saída: "Olá!"
puts p2.saudacao       # Saída: "Olá!"
```

## Closures e Blocks

Em Ruby, os blocos (Blocks) podem funcionar como closures. Isso significa que eles "capturam" o ambiente (variáveis locais) onde foram definidos e podem acessar essas variáveis mesmo quando executados em um contexto diferente.

Ruby blocks "**são pequenas funções anônimas** que podem ser passadas nos métodos". Podemos identificar quando vemos ou escrevemos no código comandos dentro dos `do...end` ou entre chaves `{}` e os argumentos vão dentro de pipes `|args|`. São frequentemente utilizados em métodos **iteradores**.

> Métodos podem aceitar blocks como parâmetro.

```ruby
# Sintaxe "do...end"
[1, 2, 3, 4, 5].each do |num|
    puts num
end

# Sintaxe {} - Bloco inline
[1, 2, 3, 4, 5].each {|num| puts num}
```

### Procs

Um Proc é apenas um objeto que você pode usar para **armazenar blocks** e passá-los como variáveis.

As Procs tem algumas particularidades, a mais notável é o fato dos argumentos **não** interferirem na execução da mesma. Procs preenche os argumentos ausentes com `nil` e um **único** argumento de array é desconstruído se o proc tiver vários argumentos.

```ruby
# Criando proc
a = Proc.new { |x, y| "x = #{x}, y = #{y}" }
b = Proc.new { "Hello, world!" }

# Executando proc
puts a.call(1, 2)       # Saída: x = 1, y = 2
puts a.call([2, 1])     # Saída: x = 2, y = 1
puts a.call(3, 4, 8)    # Saída: x = 3, y = 4
puts a.call(9)          # Saída: x = 9, y =
puts a.call             # Saída: x = , y =

# Também é possível executar um Proc com colchetes []
puts a[1, 2]            # Saída: x = 1, y = 2
```

### Lambda

Lambda e Procs são bem parecidos (Não existe uma classe lambda especial). Além disso, podemos dizer que uma lambda é uma forma de definir um bloco e seus parâmetros com uma sintaxe especial.

A lambda é como um método comum porque impõe o número de parâmetros quando é chamado e também retorna como um método normal (trata a palavra-chave `return` da mesma forma que os métodos).

A maior diferença entre Proc e Lambda se dá pela forma que tratam os argumentos. Se você passar um parâmetro para uma lambda que não o espera, você receberá um `ArgumentError`.

```ruby
# Criando lambda
lambda_a = lambda {puts "Hey"}
lambda_b = -> (x) {puts "Hello, " + x}

# Existem várias maneiras de chamar expressões lambdas
# .call
lambda_b.call("world")   # Saída: "Hello, world"

# .()
lambda_b.("world")       # Saída: "Hello, world"

# []
lambda_b["world"]        # Saída: "Hello, world"

# .===
lambda_b.===("world")    # Saída: "Hello, world"
```

## Catch/Throw

Catch e Throw são usados para **controle de fluxo não local**, ou seja, para sair de construções aninhadas profundas durante o processamento.

A instrução `catch` define um bloco que é rotulado com um nome fornecido, que pode ser um `Symbol` ou uma `String`. O bloco é executado normalmente até que um throw seja encontrado.

A instrução `throw` transfere o controle para o bloco catch que está esperando pelo Symbol ou String especificado. Se não houver um bloco catch esperando pelo Symbol (ou String) especificado pelo throw, um `NameError` é gerado. A instrução throw pode receber **um parâmetro opcional adicional**. Este valor é retornado como o valor do bloco catch. Se nenhum valor for fornecido, o valor de retorno padrão é `nil`.

Use catch/throw quando você quer interromper a execução de um bloco ou estrutura aninhada inteira sem precisar encadear vários `if` ou `return`.

> É importante notar que o `throw` **não** precisa aparecer dentro do escopo estático do catch.

```ruby
# throw dentro do bloco catch
def busca_em_listas(listas, alvo)
  catch(:encontrado) do
    listas.each_with_index do |lista, i|
      lista.each_with_index do |item, j|
        if item == alvo
          puts "Encontrado em listas[#{i}][#{j}]"
          throw(:encontrado)
        end
      end
    end
    puts "Item não encontrado"
  end
end

listas = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
busca_em_listas(listas, 5)      # Saída: "Encontrado em listas[1][1]"

# throw fora do bloco catch
def verificar_usuario(usuario)
  throw :interromper_fluxo, "Usuário inválido: #{usuario[:nome]}" if usuario[:ativo] == false
end

def processar_usuarios
  catch(:interromper_fluxo) do
    usuarios = [
      { nome: "Ana", ativo: true },
      { nome: "Carlos", ativo: false },
      { nome: "João", ativo: true }
    ]

    usuarios.each do |usuario|
      verificar_usuario(usuario) # O throw está aqui, em outro método
      puts "Processando #{usuario[:nome]}"
    end

    puts "Todos os usuários foram processados."
  end
end

resultado = processar_usuarios
puts resultado    # Saída: "Usuário inválido: Carlos"
```

## Módulo

Módulos definem uma coleção de métodos, constantes, definições de classes ou outros módulos.

Principais casos de uso:

- Atuar como "namespaces"
- Compartilhar funcionalidades entre classes (Mixins)

É possível adicionar um módulo a uma classe (ou a outro módulo) com `include` ou `extend`. Quando você _inclui_ um módulo em uma classe, os métodos do módulo se tornam **métodos de instância da classe**. Quando você _estende_ uma classe com um módulo, os métodos do módulo se tornam **métodos de classe** da classe.

Se o módulo define métodos como _métodos de módulo_ (usando `self`), você pode chamá-los diretamente usando o operador de resolução de escopo (`::`) ou ponto (`.`).

Assim como classes, os **métodos** dentro de módulos podem ter visibilidade definida, como `protected` e `private`.

O uso de `::` para chamada de método só funciona diretamente com métodos definidos com `self` dentro do módulo se ele estiver carregado como um módulo de _namespace_ (e não como mixin, por exemplo).

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
Sobre.somar 1, 2        # Erro: NoMethodError
Sobre.subtrair(2, 1)    # Saída: 1
Sobre::subtrair(3, 1)   # Saída: 2
```

### Mixin

Mixins são um mecanismo em Ruby que permite **compartilhar funcionalidades** (como métodos e constantes) entre classes sem recorrer à **herança direta**. Eles são implementados através do uso de Módulos.

O principal benefício dos mixins é **evitar a necessidade de herança múltipla**, fornecendo uma forma flexível de reutilização de código entre classes.

Internamente, o Ruby insere o módulo na cadeia de herança da classe como uma entidade intermediária (na verdade, como uma classe anônima chamada _proxy class_ ou _inclusion class_), permitindo que os métodos do módulo sejam resolvidos como se fossem herdados

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

### Classe abstrata e Interfaces

Ruby **não** possui classes abstratas (_abstract classes_) e _interfaces_ como em linguagens como Java ou C#, no entanto, o uso de módulos e convenções pode suprir essa necessidade em muitos casos.

Módulos em Ruby podem ser usados para forçar a implementação de métodos em classes que os incluem, simulando algo parecido com interfaces ou classes abstratas.

```ruby
module Forma
  def area
    raise NotImplementedError, "Você deve implementar o método area"
  end
end

class Circulo
  include Forma

  def area
    3.14 * 2 * 2
  end
end
```

## Singleton Pattern

Singleton Pattern é um padrão de projeto (_Design Pattern_) que garante a existência de apenas uma instância de uma classe especificada durante a vida útil de um programa. Mantêm um ponto global de acesso ao seu objeto.

Em Ruby, a biblioteca `singleton` torna a implementação deste padrão simples. Para usá-la, você deve **inclui-lo** na classe que deseja que seja um singleton. Incluir este módulo torna o construtor padrão (`new`) da classe **privado**. Em vez de chamar new, os usuários da classe devem chamar o método `instance`.

Os principais casos de uso para este padrão é para geração de Logs e acesso ao Banco de Dados.

```ruby
require "singleton"

class Foobar
    include Singleton

    def oi
        puts "Oi"
    end
end

foo = Foobar.new    # ERROR: 'NoMethodError'
Foobar.instance.oi  # Saída: "Oi"
```

### Singleton Class

Singleton Class (também chamada de Eigenclass ou Metaclass) é uma classe especial que é criada automaticamente para um **OBJETO** específico. Essa classe é usada para armazenar métodos que são exclusivos para aquele objeto, ou seja, métodos que não são compartilhados com outras instâncias da mesma classe.

É o mesmo que executar `object.instance_eval`.

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

São **variáveis predefinidas** que possuem um significado especial e estão **disponíveis globalmente em todo o programa**. Muitas delas são prefixadas com o sinal de dólar (`$`) e têm nomes de duas letras onde a segunda é um sinal de pontuação. Por razões "históricas", muitos desses nomes de variáveis vêm do Perl.

A biblioteca `English` pode ser incluída para fornecer nomes mais descritivos para essas variáveis globais.

> O uso dessas variáveis globais **não** é recomendado em bibliotecas, pois elas afetam o comportamento de todo o programa.

Você pode conferir a lista de variáveis especiais [clicando aqui](https://ruby-doc.org/docs/ruby-doc-bundle/Manual/man-1.4/variable.html).

## Arquivos e Serialização

Arquivos são essencialmente coleções de bits e bytes que podem ser lidos, modificados e salvos. É útil pensar neles como uma longa string ou fluxo (stream) de bytes, que seu script Ruby pode ler de cima para baixo, realizando operações ao longo do caminho.

A classe `File` e a classe `Dir` são usadas para manipular arquivos e diretórios. Um objeto arquivo é um tipo de objeto `IO`.

Serialização é o processo de converter seus dados (como objetos e classes) em um formato que pode ser armazenado. Essencialmente, significa converter seus dados em um formato armazenável como uma `string`.

Ruby permite converter um objeto em um fluxo (stream) de bytes visando o armazenamento. Este processo é denominado **marshaling**. O módulo `Marshal` é usado para serializar e desserializar objetos.

> NOTA: _Rails_ utiliza o processo de marshaling para armazenar dados de sessão de usuários.

```ruby
# Verificar se arquivo existe
puts File.exist?("exemplo.txt")  # true ou false

# Ler um arquivo
File.open("exemplo.txt", "r") do |file|
  file.each_line do |linha|
    puts linha
  end
end

# Escrever em um arquivo
File.open("exemplo.txt", "w") do |file|
  file.puts "Olá, mundo!"
end

# Listar arquivos de um diretório
Dir.entries(".").each do |entry|
  puts entry
end

# Criar e remover diretório
Dir.mkdir("novo_diretorio") unless Dir.exist?("novo_diretorio")
Dir.rmdir("novo_diretorio") if Dir.exist?("novo_diretorio")

```

### Path

A biblioteca `Pathname` (que precisa ser requerida: `require "pathname"`) fornece uma maneira orientada a objetos de trabalhar com caminhos de arquivo. Um objeto Pathname representa o nome absoluto ou relativo de um arquivo. Ele tem dois usos principais:

- **Manipulação de caminhos**: Permite manipular partes de um caminho, construir novos caminhos (usando o operador +) e verificar propriedades como se é um caminho absoluto (absolute?) ou obter o caminho real (realpath).
- **Fachada para métodos de Dir, File e FileTest**: Um objeto Pathname pode agir como um proxy para chamar métodos de status de arquivo/diretório, como file?, directory?, executable?, size, read, readlines.

## Gems

[RubyGems](https://rubygems.org/) é um utilitário de pacote (gem) e um gerenciador de pacotes para Ruby. Ele serve como um framework padronizado de empacotamento e instalação para bibliotecas e aplicações Ruby.

Se o seu código utiliza uma gem, essa gem é chamada de **dependência**.

O **gemspec** é um arquivo de metadados que fornece informações chave sobre a gem, como nome, versão, autor, arquivos a serem incluídos, caminhos de carga, e dependências. Gems podem incluir extensões nativas (código C).

O comando `bundle exec` é usado para garantir que os executáveis sejam executados no contexto das gems definidas no Gemfile.

Principais gems:

- rails: Framework web completo MVC
- grape: Cliente HTTP simples (Pode ser utilizado junto do Rails)
- devise: Autenticação flexível de usuários
- omniauth: Autenticação via provedores externos (OAuth)
- capybara: Testes de integração/simulação de navegador
- faker: Geração de dados fictícios
- pg: Driver PostgreSQL
- sqlite3: Driver SQLite (ambiente local/dev)
- kaminari: Paginação de resultados
- dotenv-rails: Carrega variáveis de ambiente via .env
- figaro: Carrega variáveis de ambiente via .yml
- rubocop: Linter e formatador de código Ruby

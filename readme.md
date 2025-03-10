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

### Variáveis de instância

Em Ruby, o '@' antes do nome de uma variável indica que ela é uma variável de instância. Variáveis de instância são associadas a uma instância de uma classe e podem ser acessadas em qualquer método dessa instância. Elas são privadas, ou seja, requer getter e setter para ser acessada fora da classe.

```ruby
class Pessoa
    # Método construtor (construct)
    def initialize(nome, idade)
        @nome = nome
        @idade = idade
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
    puts "Olá, meu nome é #{@nome} e tenho #{@idade} anos."
  end
end

pessoa = Pessoa.new("João", 30)
pessoa.apresentar  # Saída: "Olá, meu nome é João e tenho 30 anos."

pessoa.nome = "John"
puts pessoa.nome
```

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

## Symbols x Strings

Simbolo é todo objeto iniciado por dois pontos (:) seguido por uma palavra qualquer. Texto é uma string contida entre aspas simples ou duplas.

O método **\*.object_id** retorna o _id_ único do objeto, inclusive strings e inteiros. Por mais que o _conteúdo_ da string, por exemplo, seja o mesmo, o object_id será diferente. Porém, o **object_id** de um _symbol_ será o mesmo. Ou seja, a string é repetida na memória quando declarada com o mesmo conteúdo, mas o symbol não.

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

# Gemas

> TODO

## Como instalar

> TODO

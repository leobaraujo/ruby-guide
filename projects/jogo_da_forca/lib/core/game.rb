module Core
  class Game
    def initialize
      @random_word = ''
      @player_health = 0
      @player_word = ''
      @score = 0
      @errors = []
    end

    def game
      loop do
        play

        while @player_health > 0 and @player_word != @random_word do
          puts `clear`
          puts 'Jogo da Forca'
          puts "Pontuação: #{@score}"
          draw_hangman @errors.size

          @player_word.chars.each do |char|
            print char + ' '
          end

          print "\n\n> Digite uma letra: "
          input = get_user_input

          if input.empty? then add_error ' '
          elsif @random_word.include? input[0] then add_correct input[0]
          else add_error input[0] end
        end

        if @player_health < 1
          @score = 0
          puts "\nVocê perdeu! A palavra era \"#{@random_word}\".\n\n"
        end

        if @player_word == @random_word
          @score += 1
          puts "\nVocê ganhou!\n\n"
        end

        print "> Jogar novamente (s/n)? "
        input = get_user_input

        break if input[0] == 'n'
      end

      exit 0
    end

    private
      def play
        @random_word = get_random_word
        @player_word = ''
        @player_health = 6
        @errors = []

        @random_word.size.times do |i|
          @player_word[i] = '_'
        end
      end

      def get_user_input
        begin
            input = gets.chomp
            input.downcase!
            return input
          rescue ArgumentError
            puts 'Insira um caractere válido.'
          end
      end

      def get_random_word
        begin
          file = File.open('./data/words.txt')
          words = file.readlines.map { |word| word.chomp }
          random_index = Random.new.rand(0...words.size)

          words[random_index]
        ensure
          file.close unless file.nil?
        end
      end

      def add_error char
        @player_health -= 1
        @errors.push char
      end

      def add_correct char
        char_indexes = @random_word.chars.each_index.select { |i| @random_word[i] == char }
        char_indexes.each { |v| @player_word[v] = char }
      end

      def draw_hangman error_count
        case error_count
            when 0
          puts "  _______
 |/      |
 |
 |
 |
 |
_|___   Erros: #{@errors}\n\n"
      when 1
        puts "  _______
 |/      |
 |      (_)
 |
 |
 |
_|___   Erros: #{@errors}\n\n"
      when 2
        puts "  _______
 |/      |
 |      (_)
 |       |
 |
 |
_|___   Erros: #{@errors}\n\n"
      when 3
        puts "  _______
 |/      |
 |      (_)
 |      /|
 |
 |
_|___   Erros: #{@errors}\n\n"
      when 4
        puts "  _______
 |/      |
 |      (_)
 |      /|\\
 |
 |
_|___   Erros: #{@errors}\n\n"
      when 5
        puts "  _______
 |/      |
 |      (_)
 |      /|\\
 |      /
 |
_|___   Erros: #{@errors}\n\n"
      when 6
        puts "  _______
 |/      |
 |      (_)
 |      /|\\
 |      / \\
 |
_|___   Erros: #{@errors}\n\n"
      end
    end
  end
end
module CalculadoraSimples
  class Application
    def main
      puts `clear`
      print "Escolha uma das seguintes opções:\n1 - Adição\n2 - Subtração\n3 - Multiplicação\n4 - Divisão\n5 - Resto\n0 - Sair\n> Opção: "
      opcao = gets.chomp

      case opcao
      when '0' then exit 0
      when '1' then adicao
      when '2' then subtracao
      when '3' then multiplicacao
      when '4' then divisao
      when '5' then resto
      end
    end

    private

      def operacao_valores operacao_nome
        puts `clear`
        print operacao_nome + "\n> Escolha um valor para X: "
        x = gets.chomp.to_i

        print '> Escolha um valor para Y: '
        y = gets.chomp.to_i
        
        return [x, y]
      end

      def menu_opcoes
        print "\nEscolha uma das seguintes opções:\n1 - Repetir\n2 - Voltar\n0 - Sair\n> Opção: "
        return gets.chomp
      end

      def adicao
        loop do
          valores = operacao_valores 'ADIÇÃO'
          puts "Resultado: #{valores[0] + valores[1]}"

          opcao = menu_opcoes

          case opcao
          when '0' then exit 0
          when '1' then next
          when '2' then return main
          end
        end
      end

      def subtracao
        loop do
          valores = operacao_valores 'SUBTRAÇÃO'
          puts "Resultado: #{valores[0] - valores[1]}"

          opcao = menu_opcoes

          case opcao
          when '0' then exit 0
          when '1' then next
          when '2' then return main
          end
        end
      end

      def multiplicacao
        loop do
          valores = operacao_valores 'MULTIPLICAÇÃO'
          puts "Resultado: #{valores[0] * valores[1]}"

          opcao = menu_opcoes

          case opcao
          when '0' then exit 0
          when '1' then next
          when '2' then return main
          end
        end
      end

      def divisao
        loop do
          valores = operacao_valores 'DIVISÃO'

          begin
            puts "Resultado: #{valores[0] / valores[1]}"
          rescue ZeroDivisionError
            puts "Não é possível dividir por zero (0)"
          end

          opcao = menu_opcoes

          case opcao
          when '0' then exit 0
          when '1' then next
          when '2' then return main
          end
        end
      end

      def resto
        loop do
          valores = operacao_valores 'RESTO'

          begin
            puts "Resultado: #{valores[0] % valores[1]}"
          rescue ZeroDivisionError
            puts "Não é possível dividir por zero (0)"
          end

          opcao = menu_opcoes

          case opcao
          when '0' then exit 0
          when '1' then next
          when '2' then return main
          end
        end
      end
  end
end

CalculadoraSimples::Application.new.main
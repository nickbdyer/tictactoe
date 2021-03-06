require_relative 'display_constants'

module TicTacToe
  #The user interface class is responsible for user input and display output
  #on the cli.
  class User_Interface

    include DisplayConstants

    attr_reader :input, :output

    def initialize(input = $stdin, output = $stdout)
      @input, @output = input, output
    end

    def introduction
      output.puts CLEAR_SCREEN
      output.puts STARS
      output.puts TITLE
      output.puts STARS
      output.puts " "
    end

    def show(board)
      output.puts CLEAR_SCREEN
      display_board = (Object.const_get "DisplayConstants::GRIDx#{board.length}").dup
      output.puts colour_board(board, display_board)
    end

    def choose_game
      output.puts GAME_TYPE_CHOICE
      validate_input(input.gets.chomp, ["1", "2", "3"], method(:try_choose_game_again))
    end

    def name_query(number)
      output.puts "Player #{number}, what is your name?"
      input.gets.chomp
    end

    def mark_query(player)
      output.puts "#{player.name}, what mark would you like to play as?"
      output.puts MARK_CHOICE
      validate_input(input.gets.chomp, ["1", "2"], method(:try_choose_mark_again))
    end

    def human_move(board, player)
      output.puts "#{player.name}, it's your move, choose a cell by selecting a number."
      selection = validate_input(input.gets.chomp.to_i - 1, 
                                 board.available_cells, 
                                 method(:try_choose_move_again),
                                 true)
      board.mark(selection, player.symbol)
    end

    def computer_move(board, move, computer)
      output.puts "#{computer.name} is thinking."
      sleep 1 unless ENV['RUBY_ENV'] == "test"
      board.mark(move, computer.symbol)
    end

    def announce_winner(player)
      output.puts "#{player.name} is the winner."
    end

    def announce_draw
      output.puts "It is a draw!"
    end

    def another_round?
      output.puts "If you'd like to play again type 'y', or any other letter to quit."
      input.gets.chomp == "y"
    end

    private 

    def try_choose_game_again
      output.puts INSULT
      output.puts STARS
      output.puts GAME_TYPE_CHOICE
    end

    def try_choose_mark_again
      output.puts INSULT
      output.puts STARS
      output.puts MARK_CHOICE
    end

    def try_choose_move_again
      output.puts ILLEGAL_MOVE
      output.puts STARS
      output.puts "Choose a cell by selecting a number that is shown on the board."
    end

    def validate_input(user_input, options, response, zero_indexed = false)
      until options.include? user_input do
        response.call
        user_input = zero_indexed ? input.gets.chomp.to_i - 1 : input.gets.chomp
      end
      user_input
    end

    def colour_board(game_board, display_board)
      game_board.grid.each do |cell|
        display_board.sub!('#', "\e[31m#{cell}\e[0m") if cell == "X"
        display_board.sub!('#', "\e[34m#{cell}\e[0m") if cell == "O"
        display_board.sub!('#', "\e[37m#{cell}\e[0m") if cell.class == Fixnum
      end
      display_board
    end
  end

end

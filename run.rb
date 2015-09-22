require_relative 'lib/board'
require_relative 'lib/player'
require_relative 'lib/user_interface'
require_relative 'lib/computer'
require_relative 'lib/game'
require_relative 'lib/engine'


board = TicTacToe::Board.new(3)
game = Game.new(board)
user_interface = User_Interface.new
engine = Engine.new(game, user_interface)

begin
  engine.start
#rescue NoMethodError
rescue Interrupt
  puts "Exiting..."
end

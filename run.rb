require_relative 'lib/board'
require_relative 'lib/player'
require_relative 'lib/display'
require_relative 'lib/computer'
require_relative 'lib/game'
require_relative 'lib/engine'


board = Board.new(3)
game = Game.new(board)
display = Display.new
engine = Engine.new(game, display)

engine.start

require_relative 'lib/board'
require_relative 'lib/cell'
require_relative 'lib/player'
require_relative 'lib/display'
require_relative 'lib/game'
require_relative 'lib/engine'


board = Board.new(Cell, 9)
display = Display.new
game = Game.new(board)
engine = Engine.new(game, display)

engine.start


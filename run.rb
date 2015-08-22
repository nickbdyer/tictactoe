require_relative 'lib/board'
require_relative 'lib/cell'
require_relative 'lib/player'
require_relative 'lib/display'
require_relative 'lib/game'


board = Board.new(Cell, 9)
display = Display.new
nick = Player.new("Nick")
mat = Player.new("Mat")
game = Game.new
game.add_player(nick)
game.add_player(mat)


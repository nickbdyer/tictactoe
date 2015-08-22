require 'engine'
require 'display'
require 'board'
require 'game'
require 'cell'
require 'player'

describe Engine do

  let(:game) { Game.new }
  let(:board) { Board.new(Cell, 9) }
  let(:display) { Display.new }

  it "can start the game" do
    engine = Engine.new(game, board, display, Player)
    expect{engine.start}.to output("------Welcome to TicTacToe------").to_stdout
  end

end

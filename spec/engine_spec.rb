require 'engine'
require 'display'
require 'board'
require 'game'
require 'cell'
require 'player'

describe Engine do

  let(:board) { Board.new(Cell, 9) }
  let(:display) { Display.new }
  let(:game) { Game.new(board) }

  #it "can start the game" do
    #engine = Engine.new(game, display)
    #expect{engine.start}.to output("-------Welcome to TicTacToe-------").to_stdout
  #end

end

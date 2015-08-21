require 'game'

describe Game do

  let(:player1) { double :player }
  let(:player2) { double :player }

  it "can add a player" do
    game = Game.new
    game.add_player(player1)
    expect(game.player1).to eq player1
  end

  it "can add two players" do
    game = Game.new
    game.add_player(player1)
    game.add_player(player2)
    expect(game).to have_two_players
  end
end

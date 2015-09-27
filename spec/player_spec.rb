require 'player'

describe TicTacToe::Player do

  let(:ui) { double :ui }
  let(:board) { double :board }
  let(:player) { TicTacToe::Player.new(ui) }

  it "can choose a symbol" do
    player.symbol = "X"
    expect(player.symbol).to eq "X"
  end

  it "can be assigned a name" do
    player.name = "Nick"
    expect(player.name).to eq "Nick"
  end

  it "can choose a move" do
    expect(ui).to receive(:human_move)
    player.choose_move(board)
  end

  it "knows if it has a symbol" do
    player.symbol = "X"
    expect(player).to have_a_symbol
  end

  it "knows if it doesn't have a symbol" do
    expect(player).not_to have_a_symbol
  end

  it "knows if it has a name" do
    player.name = "Nick"
    expect(player).to have_a_name
  end

  it "knows if it doesn't have a name" do
    expect(player).not_to have_a_name
  end

end

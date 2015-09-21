require 'player'

describe Player do

  let(:display) { double :display }
  let(:player) { Player.new(display) }
  
  it "can choose a symbol" do
    player.symbol = "X"
    expect(player.symbol).to eq "X"
  end

  it "can be assigned a name" do
    player.name = "Nick"
    expect(player.name).to eq "Nick"
  end

  it "can choose a move" do
    expect(display).to receive(:prompt_selection)
    player.choose_move
  end

end

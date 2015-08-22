require 'player'

describe Player do

  let(:player) { Player.new }
  
  it "can choose a symbol" do
    player.symbol = "X"
    expect(player.symbol).to eq "X"
  end

  it "can be assigned a name" do
    player.name = "Nick"
    expect(player.name).to eq "Nick"
  end

end

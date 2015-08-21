require 'player'

describe Player do
  
  it "can have a symbol" do
    player = Player.new("Nick")
    player.symbol = "X"
    expect(player.symbol).to eq "X"
  end

  it "can be initialized with a name" do
    nick = Player.new("Nick")
    expect(nick.name).to eq "Nick"
  end

end

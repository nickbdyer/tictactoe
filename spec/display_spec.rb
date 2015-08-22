require 'display'

describe Display do

  let(:game) { double :game, grid: [ nil, "X", "X", "O", nil, "O", "X", "O", "X"] }

  it "can show the board" do
    display = Display.new
    expect(display.show(game)).to eq "   | X | X
    ---|---|---
     O |   | O
     ---|---|---
        X | O | X"
  end

end

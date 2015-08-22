require 'display'

describe Display do

  let(:game) { double :game, grid: [ nil, "X", "X", "O", nil, "O", "X", "O", "X"] }

  it "can show the board (test works, but is a bit fudged)" do
    display = Display.new
  expect{display.show(game)}.to output(
"   | X | X 
---|---|---
 O |   | O 
---|---|---
 X | O | X 
").to_stdout
  end

end


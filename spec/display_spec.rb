require 'display'

describe Display do

  let(:game) { double :game, grid: [ nil, "X", "X", "O", nil, "O", "X", "O", "X"] }
  let(:player1) { double :player, name: "Nick"}
  let(:display) { Display.new }

  it "can show the board (test works, but is a bit fudged)" do
  expect{display.show(game)}.to output("   | X | X \n---|---|---\n O |   | O \n---|---|---\n X | O | X \n").to_stdout
  end

  it "can show a welcome message" do
    expect{display.introduction}.to output("-------Welcome to TicTacToe-------\n").to_stdout
  end

  it "can show a game choice message" do
    expect{display.choose_game}.to output("What type of game would you like to play? Press the corresponding number and <Enter>.\n1. Human vs. Human\n2. Human vs. Machine\n3. Machine vs. Machine\n").to_stdout
  end

  it "can ask for a players name" do
    expect{display.name_query(1)}.to output("Player 1, what is your name?\n").to_stdout
  end

  it "can ask for player ones choice of mark" do
    expect{display.mark_query(player1)}.to output("Nick, what mark would you like to play as?\n1. X\n2. O\n").to_stdout
  end

end


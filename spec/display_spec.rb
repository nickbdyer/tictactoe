require 'display'

describe Display do

  let(:game) { double :game, turn: player1, winner: player1 }
  let(:player1) { double :player, name: "Nick"}
  let(:display) { Display.new($stdin, $stdout) }

  it "can show a welcome message" do
    expect{display.introduction}.to output("**********************************\n-------Welcome to TicTacToe-------\n**********************************\n").to_stdout
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

  it "can ask for input on who plays first" do
    expect{display.starting_player_query(player1)}.to output("Nick, would you like to play first? (y/n)\n").to_stdout
  end

  it "prompt a player to play" do
    expect{display.prompt_selection(game.turn)}.to output("Nick, it's your move, choose a cell from 1-9\n").to_stdout
  end

  it "can announce the winner" do
    expect{display.announce_winner(game.winner)}.to output("Nick is the winner.\nIf you'd like to play again type 'y', or any other letter to quit.\n").to_stdout
  end

  it "can announce a draw" do
    expect{display.announce_draw}.to output("It is a draw!\nIf you'd like to play again type 'y', or any other letter to quit.\n").to_stdout
  end

end


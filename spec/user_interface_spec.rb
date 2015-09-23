require 'user_interface'

describe TicTacToe::User_Interface do

  let(:game) { double :game, turn: player1, winner: player1 }
  let(:board) { double :board }
  let(:player1) { double :player, name: "Nick"}
  let(:input) { StringIO.new }
  let(:output) { StringIO.new }
  let(:ui) { TicTacToe::User_Interface.new(input, output) }

  it "can show a welcome message" do
    ui.introduction
    expect(output.string).to eq "\e[H\e[2J\n**********************************\n-------Welcome to TicTacToe-------\n**********************************\n \n"
  end

  it "can show a game choice message" do
    input = StringIO.new("1\n")
    ui = TicTacToe::User_Interface.new(input, output)
    ui.choose_game
    expect(output.string).to eq "What type of game would you like to play? Press the corresponding number and <Enter>.\n1. Human vs. Human\n2. Human vs. Machine\n3. Machine vs. Machine\n"
  end

  it "can ask for a players name" do
    input = StringIO.new("Nick\n")
    ui = TicTacToe::User_Interface.new(input, output)
    ui.name_query(1)
    expect(output.string).to eq "Player 1, what is your name?\n"
  end

  it "can ask for player ones choice of mark" do
    input = StringIO.new("1\n")
    ui = TicTacToe::User_Interface.new(input, output)
    ui.mark_query(player1)
    expect(output.string).to eq "Nick, what mark would you like to play as?\n1. X (Plays first)\n2. O\n"
  end

  it "prompt a player to play" do
    input = StringIO.new("1\n")
    ui = TicTacToe::User_Interface.new(input, output)
    allow(player1).to receive(:symbol)
    allow(board).to receive(:mark)
    ui.human_move(board, game.turn)
    expect(output.string).to eq "Nick, it's your move, choose a cell from 1-9\n"
  end

  it "can announce the winner" do
    input = StringIO.new("n\n")
    ui = TicTacToe::User_Interface.new(input, output)
    ui.announce_winner(player1)
    expect(output.string).to eq "Nick is the winner.\nIf you'd like to play again type 'y', or any other letter to quit.\n"
  end

  it "can announce a draw" do
    input = StringIO.new("n\n")
    ui = TicTacToe::User_Interface.new(input, output)
    ui.announce_draw
    expect(output.string).to eq "It is a draw!\nIf you'd like to play again type 'y', or any other letter to quit.\n"
  end

end

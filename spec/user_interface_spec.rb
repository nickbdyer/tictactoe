require 'user_interface'

describe User_Interface do

  let(:game) { double :game, turn: player1, winner: player1 }
  let(:board) { double :board }
  let(:player1) { double :player, name: "Nick"}
  let(:ui) { User_Interface.new($stdin, $stdout) }

  it "can show a welcome message" do
    expect{ui.introduction}.to output("**********************************\n-------Welcome to TicTacToe-------\n**********************************\n \n").to_stdout
  end

  it "can show a game choice message" do
    expect{ui.choose_game}.to output("What type of game would you like to play? Press the corresponding number and <Enter>.\n1. Human vs. Human\n2. Human vs. Machine\n3. Machine vs. Machine\n").to_stdout
  end

  it "can ask for a players name" do
    expect{ui.name_query(1)}.to output("Player 1, what is your name?\n").to_stdout
  end

  it "can ask for player ones choice of mark" do
    expect{ui.mark_query(player1)}.to output("Nick, what mark would you like to play as?\n1. X (Plays first)\n2. O\n").to_stdout
  end

  it "prompt a player to play" do
    $stdin = StringIO.new("1\n")
    allow(player1).to receive(:symbol)
    allow(board).to receive(:mark)
    expect{ui.human_move(board, game.turn)}.to output("Nick, it's your move, choose a cell from 1-9\n").to_stdout
  end

  it "can announce the winner" do
    expect{ui.announce_winner(game.winner)}.to output("Nick is the winner.\nIf you'd like to play again type 'y', or any other letter to quit.\n").to_stdout
  end

  it "can announce a draw" do
    expect{ui.announce_draw}.to output("It is a draw!\nIf you'd like to play again type 'y', or any other letter to quit.\n").to_stdout
  end

end


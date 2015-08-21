require 'player'

describe Player do

  let(:nick) { Player.new("Nick") }
  let(:board) { double :board, mark: true }
  
  it "can have a symbol" do
    nick.symbol = "X"
    expect(nick.symbol).to eq "X"
  end

  it "can be initialized with a name" do
    expect(nick.name).to eq "Nick"
  end

  it "can have a board" do
    nick.board = board
    expect(nick.board).to eq board
  end

  it "can mark a cell" do
    nick.symbol = "X"
    nick.board = board
    expect(board).to receive(:mark).with(0, nick)
    nick.mark_board(0)
  end

end

require 'board'
require 'cell'

describe Board do

  let(:board) { Board.new(Cell, 9) }
  let(:player1) { double :player1, symbol: "X" }

  it "can be initialized a size" do
    expect(board.grid.length).to eq 9
  end

  it "can be initilized with content" do
    expect(board.grid[0]).to be_a Cell
  end

  it "can send a mark to a cell" do
    board.mark(0, player1.symbol)
    expect(board.grid[0].content).to eq "X"
  end

  it "knows when the board is empty" do
    expect(board.empty?).to be true
  end

  it "knows when the board is full" do
    (0..8).each { |num| board.mark(num, player1.symbol) }
    expect(board.full?).to be true
  end

  it "knows when a cell is marked" do
    board.mark(0, player1)
    expect(board.can_mark?(0)).to be false
  end

  it "knows which cells are unmarked" do
    (0..3).each { |cell| board.mark(cell, player1.symbol) }
    expect(board.available_cells).to eq [4, 5, 6, 7, 8]
  end

  it "knows if there is a winner" do
    (0..2).each { |cell| board.mark(cell, player1.symbol) }
    expect(board).to have_a_winner
  end

  it "knows if there is not a winner" do
    [0,1,4].each { |cell| board.mark(cell, player1.symbol) }
    expect(board).not_to have_a_winner
  end

end

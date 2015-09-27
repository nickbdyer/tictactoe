require 'board'

describe TicTacToe::Board do

  let(:board) { TicTacToe::Board.new({}) }
  let(:player1) { double :player, symbol: "X" }
  let(:player2) { double :player, symbol: "O" }

  it "can be initialized and will default to 3x3 grid" do
    expect(board.grid).to eq [1, 2, 3, 4, 5, 6, 7, 8, 9]
    expect(board.grid.length).to eq 9
    expect(board.length).to eq 3
  end

  context "initialization with length" do

    let(:board) { TicTacToe::Board.new({ :length => 4 }) }

    it "can be initialized" do
      expect(board.grid).to eq [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]
    end

    it "is empty upon initialization" do
      expect(board.empty?).to be true
    end

    it "has a size representing the number of grid cells" do
      expect(board.size).to eq 16
    end

    it "has an integer length" do
      expect(board.length).to eql 4
      expect(board.length).not_to eql 4.0
    end

    it "has an integer size" do
      board = TicTacToe::Board.new({ :length => 4.0 })
      expect(board.size).to eql 16
      expect(board.size).not_to eql 16.0
    end

  end

  context "initialized with grid" do

    let(:board) { TicTacToe::Board.new({ :grid => [1, 2, 3,"X", 5, 6, 7, 8, 9] }) }

    it "can be initalized with a board" do
      expect(board.grid).to eq [1, 2, 3,"X", 5, 6, 7, 8, 9]
    end

    it "has a size representing the number of grid cells" do
      expect(board.size).to eq 9
    end

    it "has a length representing the width of the grid" do
      expect(board.length).to eq 3
    end

    it "has an integer length" do
      expect(board.length).to eql 3
      expect(board.length).not_to eql 3.0
    end

  end

  it "can send a mark to a cell" do
    board.mark(0, player1.symbol)
    expect(board.grid[0]).to eq "X"
  end

  it "knows if a cell is empty and can be marked" do
    expect(board.send(:can_mark?, 0)).to be true
  end

  it "knows if a cell is full and can not be marked" do
    board.mark(0, player1.symbol)
    expect(board.send(:can_mark?, 0)).to be false
  end

  it "knows which cells are unmarked" do
    (0..3).each { |cell| board.mark(cell, player1.symbol) }
    expect(board.available_cells).to eq [4, 5, 6, 7, 8]
  end

  it "knows the indexes of the corner cells" do
    expect(board.corners).to eq [0, 2, 6, 8]
  end

  it "knows the indexes of the corner cells on a larger board" do
    board = TicTacToe::Board.new({ :length => 4 })
    expect(board.corners).to eq [0, 3, 12, 15]
  end

  it "knows when the board is full" do
    (0..8).each { |num| board.mark(num, player1.symbol) }
    expect(board.full?).to be true
  end

  it "knows when the board is not full" do
    (0..4).each { |num| board.mark(num, player1.symbol) }
    expect(board.full?).to be false
  end

  it "knows when the board is empty" do
    expect(board.empty?).to be true
  end

  it "knows when the board is not empty" do
    (0..4).each { |num| board.mark(num, player1.symbol) }
    expect(board.empty?).to be false
  end

  it "knows if there are 3 Xs in a row" do
    (0..2).each { |cell| board.mark(cell, player1.symbol) }
    expect(board).to have_a_winner
  end

  it "knows if there are 3 Os in a row" do
    (0..2).each { |cell| board.mark(cell, player2.symbol) }
    expect(board).to have_a_winner
  end

  it "knows if there are not 3 symbols in a row" do
    [0,1,4].each { |cell| board.mark(cell, player1.symbol) }
    expect(board).not_to have_a_winner
  end

  it "knows which is the winning symbol" do
    (0..2).each { |cell| board.mark(cell, player2.symbol) }
    expect(board.winner).to eq "O"
  end

  it "returns nil for winning symbol if no winner" do
    (0..1).each { |cell| board.mark(cell, player2.symbol) }
    expect(board.winner).to be false
  end

  it "can be cleared" do
    (0..3).each { |cell| board.mark(cell, player1.symbol) }
    board.clear
    expect(board.available_cells.length).to eq board.size
  end

  it "can raise an error if a marking is not valid" do
    board.mark(0, player1.symbol)
    expect{board.mark(0, player2.symbol)}.to raise_error(RuntimeError, "Cell is already marked.")
    expect{board.mark(15, player2.symbol)}.to raise_error(RuntimeError, "Cell is already marked.")
  end

end

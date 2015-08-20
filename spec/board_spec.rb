require 'board'

describe Board do

  let(:cell_class) { double :cell_class }

  it "can be initialized a size" do
    board = Board.new(cell_class, 9)
    expect(board.grid.length).to eq 9
  end


end

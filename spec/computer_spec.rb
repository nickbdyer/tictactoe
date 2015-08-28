require 'computer'

describe Computer do

  let(:computer) { Computer.new }
  let(:engine) { double :engine }
  let(:empty_board) { double :board, available_moves: [0, 1, 2, 3, 4, 5, 6, 7, 8], winner: false, full?: false }
  let(:comp_win_board) { double :board, winner: "X" }
  let(:opponent_win_board) { double :board, winner: "O" }
  let(:draw_board) { double :board, full?: true, winner: false }

  def setup_computer
    computer.engine = engine
    computer.symbol = "X"
  end

  before do
    setup_computer
  end

  it "can have an engine" do
    expect(computer.engine).to eq engine
  end

  it "can have a symbol" do
    expect(computer.symbol).to eq "X"
  end

  it "can mark the board" do
    expect(engine).to receive(:process_mark).with(3)
    computer.mark(3)
  end

  it "will choose center if playing first" do
    expect(computer.choose_move).to eq 5
  end

  it "knows what the opponents symbol is" do
    expect(computer.opponent_symbol).to eq "O"
  end

  it "will score a board with 10 if it wins" do
    expect(computer.score(comp_win_board)).to eq 10
  end

  it "will score a board with -10 if it loses" do
    expect(computer.score(opponent_win_board)).to eq -10
  end

  it "will score a board with 0 if it is a draw" do
    expect(computer.score(draw_board)).to eq 0
  end

end

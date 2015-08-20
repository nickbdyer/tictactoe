require 'cell'

describe Cell do

  it "is initialized without content" do
    cell = Cell.new
    expect(cell.content).to eq nil
  end

  it "can have content assigned to it" do
    cell = Cell.new
    cell.content = "X"
    expect(cell.content).to eq "X"
  end

  
end

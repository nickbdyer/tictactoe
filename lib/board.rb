class Board

  attr_reader :grid

  def initialize(content, size)
    @grid = []
    create_grid(content, size)
  end

  def mark(cell)
    @grid[cell].content = "X"
  end

  def empty?
    @grid.any? { |cell| cell.content == nil }
  end

  def full?
    @grid.any? { |cell| cell.content != nil }
  end

  def can_mark?(cell)
    @grid[cell].content == nil
  end

  def available_cells
    (0..8).to_a.keep_if { |cell| can_mark?(cell) }
  end

  def has_a_winner?
    interpolate_markings.any? do |group| 
      group.uniq == (["X"] || ["O"])
    end
  end

  private

  def interpolate_markings
    possible_groups = rows + columns + diagonals
    possible_groups.each do |group|
      group.map! { |element| element.content }
    end
    possible_groups
  end

  def rows
    @grid.each_slice(3).to_a
  end

  def columns
    rows.transpose
  end

  def diagonals
    [] << (0..2).collect { |i| rows[i][i] } << (0..2).collect { |i| rows[i].reverse[i] }
  end

  def create_grid(content, size)
    size.times { @grid << content.new }
    @grid
  end

end

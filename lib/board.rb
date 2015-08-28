class Board

  attr_reader :grid

  def initialize(content, size)
    @grid = []
    create_grid(content, size)
  end

  def mark(cell, symbol)
    raise RuntimeError.new("You are an idiot.") unless can_mark?(cell)
    @grid[cell].content = symbol
  end

  def empty?
    @grid.all? { |cell| cell.content == nil }
  end

  def full?
    @grid.all? { |cell| cell.content != nil }
  end

  def can_mark?(cell_index)
    !!@grid[cell_index] && @grid[cell_index].content == nil
  end

  def available_cells
    (0..8).to_a.keep_if { |cell| can_mark?(cell) }
  end

  def has_a_winner?
    possible_combinations.any? do |group| 
      group.uniq == ["X"] || group.uniq == ["O"]
    end
  end

  def winner
    possible_combinations.any? do |group|
      return "X" if group.uniq == ["X"] 
      return "O" if group.uniq == ["O"] 
    end
  end

  def clear
    @grid.each { |cell| cell.content = nil }
  end

  private

  def possible_combinations
    groups = rows + columns + diagonals
    groups.each do |group|
      group.map! { |element| element.content }
    end
  end

  def rows
    @grid.each_slice(3).to_a
  end

  def columns
    rows.transpose
  end

  def diagonals
    [] << left_to_right_diagonal << right_to_left_diagonal
  end

  def left_to_right_diagonal
    (0..2).collect { |i| rows[i][i] } 
  end

  def right_to_left_diagonal
    (0..2).collect { |i| rows[i].reverse[i] }
  end

  def create_grid(content, size)
    size.times { @grid << content.new }
    @grid
  end

end

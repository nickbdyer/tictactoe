class Board

  attr_reader :grid, :size

  def initialize(length)
    @size = length**2
    @grid = []
    create_grid(size)
  end

  def mark(cell, symbol)
    raise RuntimeError.new("Cell is already marked.") unless can_mark?(cell)
    grid[cell] = symbol
  end

  def empty?
    grid.all? { |cell| cell.class == Fixnum }
  end

  def full?
    grid.all? { |cell| cell.class != Fixnum }
  end

  def can_mark?(cell_index)
    grid[cell_index].class == Fixnum
  end

  def available_cells
    (0..size - 1).to_a.keep_if { |cell| can_mark?(cell) }
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
    create_grid(size) 
  end

  private

  def possible_combinations
    groups = rows + columns + diagonals
  end

  def rows
    grid.each_slice(3).to_a
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

  def create_grid(size)
    @grid = (1..size).to_a
  end

end

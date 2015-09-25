module TicTacToe
  #The board class is responsible for storing marks on the grid, and returning
  #information for the game logic, and computer ai.
  class Board

    attr_reader :size, :length, :grid

    def initialize(args)
      @length = args[:length] || 3
      @size = length**2
      @grid = args[:grid] ? process_grid(args[:grid]) : create_grid(size)
    end

    def mark(cell, symbol)
      raise RuntimeError.new("Cell is already marked.") unless can_mark?(cell)
      grid[cell] = symbol
    end

    def full?
      available_cells.length == 0
    end

    def empty?
      available_cells.length == size
    end

    def can_mark?(cell_index)
      grid[cell_index].is_a? Fixnum
    end

    def available_cells
      (0..size - 1).to_a.keep_if { |cell| can_mark?(cell) }
    end

    def corners
      [0, (length - 1), (size - length), (size - 1)]
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
      @grid = create_grid(size) 
    end

    private

    def possible_combinations
      groups = rows + columns + diagonals
    end

    def rows
      grid.each_slice(length).to_a
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
      (1..size).to_a
    end

    def process_grid(grid)
      @size = grid.length
      @length = Math::sqrt(size)
      grid
    end

  end
end

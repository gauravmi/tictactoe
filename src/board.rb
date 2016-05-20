load './src/matrix.rb'
require 'rubygems'
require 'pry'

class EmptyBoard < Exception
end

class Board
  include Matrix

  def initialize
    @matrix = [ ['r0c0', 'r0c1', 'r0c2'],
                ['r1c0', 'r1c1', 'r1c2'],
                ['r2c0', 'r2c1', 'r2c2']  ]
  end

  def player_at(x, y)
    return nil if position_empty?(@matrix[x][y])
    @matrix[x][y]
  end

  def who_won?
    return row_with_identical_values[0] if row_with_identical_values
    return col_with_identical_values[0] if col_with_identical_values
    return diagonal_with_identical_values[0] if diagonal_with_identical_values
    return "Draw" if isDraw?
  end

  def isDraw?

  end

  def flatten
    @matrix.flatten
  end

  def mark(player, position_x, position_y)
    @matrix[position_x][position_y] = player.to_s
  end

  def mark_random
    @matrix.flatten.select{|e| }
  end

  def to_s
    p @matrix
  end

  private
  def position_empty?(position)
    !position.match(/r\dc\d/).nil?
  end

  def row_with_identical_values
    winning_row = nil
    each_row { |row| winning_row = same_values_in_a_seq(row) }
    winning_row
  end

  def col_with_identical_values
    winning_column = nil
    each_column { |column| winning_column = same_values_in_a_seq(column) }
    winning_column
  end

  def diagonal_with_identical_values
    winning_d = nil
    each_diagonal { |d| winning_d = same_values_in_a_seq(d) }
    winning_d
  end

  def is_board_empty?
    @matrix.all? { |row| row.all?{|position|  !position.match(/r\dc\d/).nil? } }
  end
end
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
    return winner if winner
    return "Draw" if isDraw?
  end

  def game_over?
    return @matrix.all?{|r| r.all?{|p| !position_empty?(p) } } || !winner.nil?
  end

  def isDraw?
    winner.nil? && game_over?
  end

  def flatten
    @matrix.flatten
  end

  def mark(player, position_x, position_y)
    @matrix[position_x][position_y] = player.to_s
  end

  def mark_random
    # @matrix.flatten.select{|e| }
  end

  def to_s
    p @matrix
  end

  private
  def winner
    return row_with_identical_values[0] if row_with_identical_values
    return col_with_identical_values[0] if col_with_identical_values
    return diagonal_with_identical_values[0] if diagonal_with_identical_values
  end

  def position_empty?(position)
    !position.match(/r\dc\d/).nil?
  end

  def winning_sequence(matrix)
    winning_row = nil
    matrix.each { |row| winning_row = same_values_in_a_seq(row) if same_values_in_a_seq(row) }
    winning_row
  end

  def row_with_identical_values
    winning_sequence(each_row)
  end

  def col_with_identical_values
    winning_sequence(each_column)
  end

  def diagonal_with_identical_values
    winning_sequence(each_diagonal)
  end

  def is_board_empty?
    @matrix.all? { |row| row.all?{|position|  !position.match(/r\dc\d/).nil? } }
  end
end
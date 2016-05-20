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

  def flatten
    @matrix.flatten
  end

  def mark(player, position_x, position_y)
    @matrix[position_x][position_y] = player.to_s
  end

  def mark_random
    @matrix.flatten.select{|e| }
  end

  def who_won?
    return winner_row[0] if winner_row
    return winner_column[0] if winner_column
    return winner_diagonal[0] if winner_diagonal
    return "Draw" if isDraw?
  end

  def isDraw?

  end

  def to_s
    p @matrix
  end

  private
  def position_empty?(position)
    !position.match(/r\dc\d/).nil?
  end

  def winner_row
    winning_row = nil
    each_row.any? { |row| winning_row = same_values_in_a_seq(row) }
    winning_row
  end

  def winner_column
    winning_column = nil
    each_column.any? { |column| winning_column = same_values_in_a_seq(column) }
    winning_column
  end

  def winner_diagonal
    winning_d = nil
    each_diagonal.any? { |d| winning_d = same_values_in_a_seq(d) }
    winning_d
  end

  def is_board_empty?
    @matrix.all? { |row| row.all?{|position|  !position.match(/r\dc\d/).nil? } }
  end
end
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

  def empty_position_on(row)
    row.find{|e| e.match(/r\dc\d/) }
  end

  def index(element)
    flatten_position = @matrix.flatten.index(element)
    row_size = @matrix.first.size
    [flatten_position/row_size, flatten_position % row_size]    
  end

  def player_at(x, y)
    return nil if position_empty?(@matrix[x][y])
    @matrix[x][y]
  end

  def check_rows(player) # logic belongs to board analyser
    about_to_win_row = @matrix.select{ |row| row.select{|p| p.to_s == player.to_s }.length == 2 }.first
    index(empty_position_on(about_to_win_row)) if about_to_win_row
  end

  def check_columns(player)  # logic belongs to board analyser
    about_to_win_column = @matrix.transpose.find{ |row| row.select{|p| p.to_s == player.to_s }.length == 2 }
    index(empty_position_on(about_to_win_column)) if about_to_win_column
  end

  def check_diagonals(player)  # logic belongs to board analyser
    position = each_diagonal.collect do |diagonal|
      player_winning_count = diagonal.select{|p| p.to_s == player.to_s }.count
      index(empty_position_on(diagonal)) if player_winning_count == 2  
    end

    return position[0] unless position.empty?
  end

  def is_winning?(player)
    [ check_rows(player), check_columns(player), check_diagonals(player) ].find{|e| e.is_a?(Array) }
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
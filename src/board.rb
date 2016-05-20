require 'rubygems'
require 'pry'
EMPTY = 0
COMPLETED = 1
INPLAY = 2
class EmptyBoard < Exception
end

class Board
  def initialize
    @matrix = [ ['r0c0', 'r0c1', 'r0c2'],
                ['r1c0', 'r1c1', 'r1c2'],
                ['r2c0', 'r2c1', 'r2c2']  ]
  end

  def position_empty?(position)
    !position.match(/r\dc\d/).nil?
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

  def check_rows(player)
    winning_row = @matrix.select{ |row| row.select{|p| p.to_s == player.to_s }.length == 2 }.first
    index(player_not_present_at_element(winning_row)) if winning_row
  end

  def check_columns(player)
    winning_row = @matrix.transpose.find{ |row| row.select{|p| p.to_s == player.to_s }.length == 2 }
    index(player_not_present_at_element(winning_row)) if winning_row
  end

  def left_diagonal
    (0..@matrix.length-1).collect{|i| @matrix[i][i] }
  end

  def right_diagonal
    offset = @matrix.length
    (0..@matrix.length-1).collect{|i| offset=offset-1; @matrix[i][offset] }
  end

  def empty_position_on_left_diagonal(player)
    diagonal = left_diagonal
    player_winning_count = diagonal.select{|p| p.to_s == player.to_s }.count

    index(player_not_present_at_element(diagonal)) if player_winning_count == 2
  end

  def empty_position_on_right_diagonal(player)
    diagonal = right_diagonal
    player_winning_count = diagonal.select{|p| p.to_s == player.to_s }.count
    
    index(player_not_present_at_element(diagonal)) if player_winning_count == 2
  end

  def check_diagonals(player)
    position = empty_position_on_left_diagonal(player)
    return position if position
    empty_position_on_left_diagonal(player)
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

  def each_row(&block)
    @matrix.each(&block)
  end

  def each_column(&block)
    @matrix.transpose.each(&block)
  end

  def each_digonal(&block) 
    [left_diagonal, right_diagonal].each(&block)
  end

  def who_won?
    return winner_on_the_row[0] if winner_on_the_row
    return winner_on_the_column[0] if winner_on_the_column
    return winner_on_the_diagonal[0] if winner_on_the_diagonal
    return "Draw" if isDraw?
  end

  def isDraw?
  end

  def to_s
    p @matrix
  end

  private

  def same_values_in_a_seq(sequence)
    sequence if (sequence.uniq.count == 1)
  end

  def winner_on_the_row
    winning_row = nil
    each_row.any? { |row| winning_row = same_values_in_a_seq(row) }
    winning_row
  end

  def winner_on_the_column
    winning_column = nil
    each_column.any? { |column| winning_column = same_values_in_a_seq(column) }
    winning_column
  end

  def winner_on_the_diagonal
    winning_d = nil
    each_digonal.any? { |d| winning_d = same_values_in_a_seq(d) }
    winning_d
  end

  def is_board_empty?
    @matrix.all? { |row| row.all?{|position|  !position.match(/r\dc\d/).nil? } }
  end
end



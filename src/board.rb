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

  def empty_position(row)
    row.find{|e| e.match(/r\dc\d/) }
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
    
  def left_diagonal(player)
    diagonal = (0..@matrix.length-1).collect{|i| @matrix[i][i] }
    player_winning_count = diagonal.select{|p| p.to_s == player.to_s }.count

    if player_winning_count == 2
        return index(player_not_present_at_element(diagonal))
    end
  end

  def right_diagonal(player)
    offset = @matrix.length
    diagonal = (0..@matrix.length-1).collect{|i| offset=offset-1; @matrix[i][offset] }
    player_winning_count = diagonal.select{|p| p.to_s == player.to_s }.count
    if player_winning_count == 2
        return index(player_not_present_at_element(diagonal))
    end
  end

  def check_diagonals(player)
    position = left_diagonal(player)
    return position if position

    right_diagonal(player)
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
  end

  def whoAon?
  end

  def takeBack
  end

  def isDraw?
  end

  def to_s
    p @matrix
  end

  private
  def is_board_empty?
    @matrix.all? do |row|
      row.all?{|position|  !position.match(/r\dc\d/).nil? }
    end
  end
end



load './src/player.rb'

require 'pry'
module BoardAnalyzer
  def with_strategy
    position_x, position_y = analyze_and_get_position
    yield(position_x, position_y)
  end

  def opponent(player)
    ObjectSpace.each_object(Player).select{|p| p.class != player.class }.first
  end

  def empty_position_on(row)
    row.find{|e| e.match(/r\dc\d/) }
  end

  private
  def analyze_and_get_position
    winning_position = robot_winning?
    return winning_position if winning_position

    dont_let_opponent_win_position = is_winning?(opponent(self))
    return dont_let_opponent_win_position if dont_let_opponent_win_position

    find_appropriate_position
  end

  def robot_winning?
    is_winning?(self)
  end

  def index(element)
    flatten_position = @board.flatten.index(element)
    row_size = @board.each_row.first.size
    [flatten_position/row_size, flatten_position % row_size]    
  end

  def check_rows(player)
    about_to_win_row = @board.each_row.select{ |row| row.select{|p| p.to_s == player.to_s }.length == 2 }.first
    index(empty_position_on(about_to_win_row)) if about_to_win_row
  end

  def check_columns(player)
    about_to_win_column = @board.each_column.find{ |row| row.select{|p| p.to_s == player.to_s }.length == 2 }
    index(empty_position_on(about_to_win_column)) if about_to_win_column
  end

  def check_diagonals(player)
    position = @board.each_diagonal.collect do |diagonal|
      player_winning_count = diagonal.select{|p| p.to_s == player.to_s }.count
      index(empty_position_on(diagonal)) if player_winning_count == 2  
    end

    return position[0] unless position.empty?
  end

  def is_winning?(player)
    [ check_rows(player), check_columns(player), check_diagonals(player) ].find{|e| e.is_a?(Array) }
  end

  def is_user_player_winning?
    @board.is_user_player_winning?(self)
  end

  def marking_first_time?
      [ @board.each_row.select{|r| r.select{|e| e == self.to_s } },
      @board.each_column.select{|c| c.select{|e| e == self.to_s } },
      @board.each_diagonal.select{|d| d.select{|e| e == self.to_s } }].any?
  end

  def mark_random
    @board.mark_random
  end

  def find_appropriate_position
    mark_random if marking_first_time?
  end
end


# x x x
# x x x
# x x x
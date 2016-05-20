require 'pry'
module BoardAnalyzer
  def with_strategy
    position_x, position_y = analyze_and_get_position
    yield(position_x, position_y)
  end

  def empty_position_on(row)
    row.find{|e| e.match(/r\dc\d/) }
  end

  private
  def robot_win_position(klass)
    is_winning?(klass)
  end
  
  alias dont_let_opponent_win_position robot_win_position

  def analyze_and_get_position
    return robot_win_position(self) if robot_win_position(self)
    return dont_let_opponent_win_position(self.opponent) if dont_let_opponent_win_position(self.opponent)

    find_appropriate_position
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

  def find_appropriate_position
    [rand(0..@board.length),rand(0..@board.length)] if @board.is_board_empty?
  end
end


# x x x
# x x x
# x x x
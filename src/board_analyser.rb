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

  def check_rows(player) #same code1
    about_to_win_row = @board.each_row.select{ |row| row.select{|p| p.to_s == player.to_s }.length == 2 }.first #magic number
    index(empty_position_on(about_to_win_row)) if about_to_win_row
  end

  def check_columns(player) #same code1
    about_to_win_column = @board.each_column.find{ |row| row.select{|p| p.to_s == player.to_s }.length == 2 } #magic number
    index(empty_position_on(about_to_win_column)) if about_to_win_column
  end

  def check_diagonals(player) #almost same code1
    position = @board.each_diagonal.collect do |diagonal|
      player_winning_count = diagonal.select{|p| p.to_s == player.to_s }.count
      index(empty_position_on(diagonal)) if player_winning_count == 2  #magic number
    end

    return position[0] unless position.empty?
  end

  def is_winning?(player)
    [ check_rows(player), check_columns(player), check_diagonals(player) ].find{|e| e.is_a?(Array) }
  end

  def is_user_player_winning? # duplicate
    @board.is_user_player_winning?(self)
  end

  def find_appropriate_position
    [rand(0..@board.length), rand(0..@board.length)] if @board.is_board_empty?
    if @board.number_of_empty_locations==8 # magic no. calculates random position after the first move made by user
      exclude_position1, exclude_position2 = @board.init_move
      return [((0..2).to_a - [exclude_position1]).sample,  ((0..2).to_a - [exclude_position2]).sample]
    end
    return move_closest_to_any_robot_move
  end

  def move_closest_to_any_robot_move
    # in progress
    [1, 1]
  end
end


# x x x
# x x x
# x x x
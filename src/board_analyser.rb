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

  private
  def analyze_and_get_position
    winning_position = robot_winning?
    return winning_position if winning_position

    dont_let_opponent_win_position = @board.is_winning?(opponent(self))
    return dont_let_opponent_win_position if dont_let_opponent_win_position

    find_appropriate_position
  end

  def robot_winning?
    @board.is_winning?(self)
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
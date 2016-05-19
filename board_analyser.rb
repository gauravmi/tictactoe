load './player.rb'

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
		
		position = @board.is_winning?(opponent(self))
		return position if position

		find_appropriate_position
	end

	def robot_winning?
		@board.is_winning?(self)
	end

	def dont_let_opponent_win_position

	end

	def winning_position
	end

	def is_user_player_winning?
		@board.is_user_player_winning?(self)
	end

	def find_appropriate_position

	end
end


# x x x
# x x x
# x x x



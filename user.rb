load './player.rb'

class UserPlayer < Player
	attr_reader :player
	private_class_method :new
	
	def initialize(board)
		@board = board
	end

	def self.instance(board)
		@@player ||= new(board)
	end

	def move(position_x, position_y)
		@board.mark(self, position_x, position_y)
	end
	
	def to_s
		"user"
	end
end
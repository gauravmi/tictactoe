load './src/board_analyser.rb'
load './src/player.rb'

class RobotPlayer < Player
  include BoardAnalyzer
  private_class_method :new

  def initialize(board)
    @board = board
  end

  def self.instance(board)
    @@player ||= new(board)
  end

  def move
    with_strategy do |position_x, position_y|
      @board.mark(self, position_x, position_y)
    end
  end

  def to_s
    "robot"
  end
end

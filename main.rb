load './src/board.rb'
load './src/user.rb'
load './src/robot.rb'

board        = Board.new
player       = UserPlayer.instance(board)
robot_player = RobotPlayer.instance(board)

player.move(1, 0)
player.move(1, 1)
robot_player.move

# player.move(2, 2)

# p board.who_won?

# board.player_at(1,1)
print board
load './board.rb'
load './user.rb'
load './robot.rb'

board        = Board.new
player       = UserPlayer.instance(board)
robot_player = RobotPlayer.instance(board)


player.move(0, 0)
player.move(2, 2)
robot_player.move

print board
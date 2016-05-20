load './src/board.rb'
load './src/user.rb'
load './src/robot.rb'

board        = Board.new
player       = UserPlayer.instance(board)
robot_player = RobotPlayer.instance(board)

# player.move(0, 0)
# player.move(1, 1)
# robot_player.move
# board.show

# player.move(0, 0)
# player.move(0, 1)
# robot_player.move
# board.show

# board.who_won?
# board.player_at(1,1)
# board.game_over?
# board.is_draw?
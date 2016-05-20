load './src/board.rb'
load './src/user.rb'
load './src/robot.rb'

board        = Board.new
player       = UserPlayer.instance(board)
robot_player = RobotPlayer.instance(board)

# player.move(0, 0)
# player.move(0, 1)
# player.move(0, 2)

# player.move(1, 0)
# player.move(1, 1)
# player.move(1, 2)

# player.move(2, 0)
# player.move(2, 1)
# player.move(2, 2)

# robot_player.move
# robot_player.move


# board.who_won?
# board.player_at(1,1)
# board.game_over?
# board.is_draw?
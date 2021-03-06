require_relative 'view'

class Controller
  attr_reader :robot

  def initialize(robot, table)
    @robot = robot
    @table = table
  end

  # Puts the robot at the given position, if position is valid.
  # If the position is not valid, error given.
  # x_pos is the robot's horizontal position
  # y_pos is the robot's vertical position
  # dir is the cardinal direction the robot is facing
  # Example of robot's position from diagram below: 4,1,NORTH
  # Y coordinate
  #  5 ^
  #  4 |
  #  3 |
  #  2 |
  #  1 |     🤖
  #  0 +---------> X coordinate
  #     1 2 3 4 5
  def place(x_pos, y_pos, dir)
    if @table.valid_place?(x_pos, y_pos)
      @robot.set_new_position(x_pos, y_pos, dir)
    else
      View.new.error("That place is invalid")
    end
  end

  # Attempts to move the robot 1 unit forward in the direction it is facing.
  # For example: 2,1,NORTH => 2,2,NORTH
  # If the command and move is valid, the robots position is updated.
  # If the command and move are invalid, errors are given.
  def move
    if @robot.on_table
      @table.valid_move?(@robot) ? @robot.move_forward : View.new.error("That move is invalid")
    else
      View.new.error("You need to first place")
    end
  end

  # Rotates the robot left (-1) or right (+1), if command is valid.
  # If command is not valid, error given.
  # Position coordinates stay the same, direction changes.
  def rotate(direction)
    @robot.on_table ? @robot.update_direction(direction) : View.new.error("You need to first place")
  end

  # Reports the robots current position to the user
  def report
    View.new.display_position(@robot)
  end
end

require_relative 'view'
require 'pry'

class Controller
  attr_reader :toy_robot

  def initialize(toy_robot, tabletop)
    @toy_robot = toy_robot
    @tabletop = tabletop
  end

  # Puts the toy robot at the given position, if position is valid.
  # If the position is not valid, error given.
  # x_pos is the toy robot's horizontal position
  # y_pos is the toy robot's vertical position
  # dir is the cardinal direction the toy robot is facing
  # Toy robot's position from diagram below: 4,1,NORTH
  # Y cooordinate
  #  5 ^
  #  4 |
  #  3 |
  #  2 |
  #  1 |     🤖
  #  0 +---------> X coordinate
  #     1 2 3 4 5
  def place(x_pos, y_pos, dir)
    if valid_place?(x_pos, y_pos)
      set_new_position(x_pos, y_pos, dir)
    else
      View.new.error("That PLACE is invalid")
    end
  end

  # Attempts to move the toy robot 1 unit forward in the direction it is facing.
  # For example: 2,1,NORTH => 2,2,NORTH
  # If the command and move is valid, the robots position is updated.
  # If the command and move are invalid, errors are given.
  def move
    if @toy_robot.on_table
      valid_move? ? move_forward : View.new.error("That MOVE is invalid")
    else
      View.new.error("You need to first PLACE")
    end
  end

  # Rotates the toy robot left (-1) or right (+1), if command is valid.
  # If command is not valid, error given.
  # Position coordinates stay the same, direction changes.
  def rotate(direction)
    @toy_robot.on_table ? update_direction(direction) : View.new.error("You need to first PLACE")
  end

  # Reports the robots current position to the user
  def report
    View.new.display_position(@toy_robot)
  end

  private

  # Validates if place is valid
  # Coordinates x and y can't be negative and can't be larger than table size
  def valid_place?(x_position, y_position)
    x_position.between?(0, @tabletop.dimension) &&
      y_position.between?(0, @tabletop.dimension)
  end

  # Validates if move is valid
  # Move can not result in coordinates x and y being negative or larger than table size
  def valid_move?
    invalid_position1 = (@toy_robot.x_position == @tabletop.dimension) && (@toy_robot.direction == 'EAST')
    invalid_position2 = @toy_robot.x_position.zero? && (@toy_robot.direction == 'WEST')
    invalid_position3 = (@toy_robot.y_position == @tabletop.dimension) && (@toy_robot.direction == 'NORTH')
    invalid_position4 = @toy_robot.y_position.zero? && (@toy_robot.direction == 'SOUTH')
    !(invalid_position1 || invalid_position2 || invalid_position3 || invalid_position4)
  end

  # Sets new position of toy robot
  def set_new_position(x_pos, y_pos, dir)
    @toy_robot.x_position = x_pos
    @toy_robot.y_position = y_pos
    @toy_robot.direction = dir
    @toy_robot.on_table = true
  end

  # Moves position of toy robot 1 unit forward
  def move_forward
    case @toy_robot.direction
    when 'NORTH' then (@toy_robot.y_position += 1)
    when 'SOUTH' then (@toy_robot.y_position -= 1)
    when 'EAST' then (@toy_robot.x_position += 1)
    when 'WEST' then (@toy_robot.x_position -= 1)
    end
  end

  # Updates direction of toy robot
  def update_direction(new_direction)
    directions = %w[NORTH EAST SOUTH WEST].freeze
    case new_direction
    when 'left'
      @toy_robot.direction = directions[(directions.index(@toy_robot.direction) - 1) % 4]
    when 'right'
      @toy_robot.direction = directions[(directions.index(@toy_robot.direction) + 1) % 4]
    end
  end
end

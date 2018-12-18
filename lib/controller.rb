require_relative 'view'
require 'pry'

class Controller
  attr_reader :toy_robot

  def initialize(toy_robot, tabletop)
    @toy_robot = toy_robot
    @tabletop = tabletop
  end

  # Puts the robot at the given position, if position is valid.
  # If the position is not valid, error given.
  # position_x is the robot's horizontal position
  # position_y is the robot's vertical position
  # see the chart below:
  # Y cooordinate
  #   ^
  #   |
  #   |
  #   |
  #   +-------> X coordinate
  # (0,0): SOUTH WEST most corner
  def place(position_x, position_y, direction)
    if valid_place?(position_x, position_y)
      set_position(position_x, position_y, direction)
    else
      View.new.error("That PLACE is invalid")
    end
  end

  # Attempts to move the robot 1 unit forward.
  # If the command and move is valid, the robots position is updated.
  # If the command and move are invalid, errors are given.
  def move
    if @toy_robot.on_table
      if valid_move?
        update_position
      else
        View.new.error("That MOVE is invalid")
      end
    else
      View.new.error("You need to first PLACE")
    end
  end

  # Rotates the robot to the left (-1) or right (+1).
  # Position coordinates stay the same, direction changes.
  # The four main cardinal directions are: North, East, South and West
  #      N
  #      |
  #      |
  # W----+-----E
  #      |
  #      |
  #      S
  def rotate(direction)
    if @toy_robot.on_table
      update_direction(direction)
    else
      View.new.error("You need to first PLACE")
    end
  end

  # Reports the robots current position
  def report
    toy_robot = @toy_robot
    View.new.display(toy_robot)
  end

  private

  # Validates if place is valid
  # Coordinates x and y can't be negative and can't be larger than table size
  def valid_place?(position_x, position_y)
    position_x.between?(0, @tabletop.dimension) &&
      position_y.between?(0, @tabletop.dimension)
  end

  # Validates if move is valid
  # Move can not result in coordinates x and y being negative or larger than table size
  def valid_move?
    invalid_position1 = (@toy_robot.position_x == @tabletop.dimension) && (@toy_robot.direction == 'EAST')
    invalid_position2 = @toy_robot.position_x.zero? && (@toy_robot.direction == 'WEST')
    invalid_position3 = (@toy_robot.position_y == @tabletop.dimension) && (@toy_robot.direction == 'NORTH')
    invalid_position4 = @toy_robot.position_y.zero? && (@toy_robot.direction == 'SOUTH')
    !(invalid_position1 || invalid_position2 || invalid_position3 || invalid_position4)
  end

  # Sets new position of toy robot
  def set_position(position_x, position_y, direction)
    @toy_robot.position_x = position_x
    @toy_robot.position_y = position_y
    @toy_robot.direction = direction
    @toy_robot.on_table = true
  end

  # Updates position of toy robot
  def update_position
    case @toy_robot.direction
    when 'NORTH' then (@toy_robot.position_y += 1)
    when 'SOUTH' then (@toy_robot.position_y -= 1)
    when 'EAST' then (@toy_robot.position_x += 1)
    when 'WEST' then (@toy_robot.position_x -= 1)
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

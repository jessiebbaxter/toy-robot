require_relative 'view'
require 'pry'

class Controller
	attr_reader :toy_robot

	def initialize(toy_robot, tabletop)
		@toy_robot = toy_robot
		@tabletop = tabletop
		@directions = %w(NORTH EAST SOUTH WEST).freeze
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
	def place(x,y,d)
		if valid_place?(x,y)
			@toy_robot.position_x = x
			@toy_robot.position_y = y
			@toy_robot.direction = d
			@toy_robot.on_table = true
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
				@toy_robot.update_position(@toy_robot)
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
			case direction
			when 'left'
				@toy_robot.direction = calculate_new_direction(-1)
			when 'right'
				@toy_robot.direction = calculate_new_direction(1)
			end
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

	def calculate_new_direction(direction_shift)
		@directions[(@directions.index(@toy_robot.direction) + direction_shift) % 4]
	end

	# Validates if place is valid
	# Coordinates x and y can't be negative and can't be larger than table size
	def valid_place?(x,y)
		x.between?(0, @tabletop.dimension) && 
		y.between?(0, @tabletop.dimension)
	end

	# Validates if move is valid
	# Move can not result in coordinates x and y being negative or larger than table size
	def valid_move?
		invalid_position_1 = (@toy_robot.position_x == @tabletop.dimension) && (@toy_robot.direction == 'EAST')
		invalid_position_2 = (@toy_robot.position_x == 0) && (@toy_robot.direction == 'WEST')
		invalid_position_3 = (@toy_robot.position_y == @tabletop.dimension) && (@toy_robot.direction == 'NORTH')
		invalid_position_4 = (@toy_robot.position_y == 0) && (@toy_robot.direction == 'SOUTH')
		valid_move = !(invalid_position_1 || invalid_position_2 || invalid_position_3 || invalid_position_4)
	end
end

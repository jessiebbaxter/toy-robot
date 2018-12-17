require_relative 'view'
require 'pry'

class Controller
	def initialize(toy_robot, tabletop)
		@toy_robot = toy_robot
		@tabletop = tabletop
	end

	# # Gets position of place command and validates input.
	# # If invalid, error given.
	# def place_position
	# response = View.new.ask_for_position_details
	# 	x = response.split(",")[0]
	# 	y = response.split(",")[1]
	# 	f = response.split(",")[2]
	# 	valid_directions = %w(north east south west)
	# 	if is_integer?(x) && is_integer?(y) && valid_directions.include?(f.downcase)
	# 		place(x.to_i,y.to_i,f.downcase)
	# 	else
	# 		View.new.error("'#{response}' is an invalid place command")
	# 	end
	# end

	# Puts the robot at the given position, if position is valid.
  # If the position is not valid, error given.
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
		if valid_command?
			if valid_move?
				case @toy_robot.direction
				when "NORTH" then (@toy_robot.position_y += 1)
				when "SOUTH" then (@toy_robot.position_y -= 1)
				when "EAST" then (@toy_robot.position_x += 1)
				when "WEST" then (@toy_robot.position_x -= 1)
				end
			else
				View.new.error("That MOVE is invalid")
			end
		else
			View.new.error("You need to first PLACE")
		end
	end

	# Rotates the robot to the left or right.
  # Position coordinates stay the same, direction changes.
	def rotate(direction)
		if valid_command?
			if (direction == "left") && (@toy_robot.direction == "NORTH")
				@toy_robot.direction = "WEST"
				elsif (direction == "right") && (@toy_robot.direction == "NORTH")
					@toy_robot.direction = "EAST"
				elsif (direction == "left") && (@toy_robot.direction == "SOUTH")
					@toy_robot.direction = "EAST"
				elsif (direction == "right") && (@toy_robot.direction == "SOUTH")
					@toy_robot.direction = "WEST"
				elsif (direction == "left") && (@toy_robot.direction == "EAST")
					@toy_robot.direction = "NORTH"
				elsif (direction == "right") && (@toy_robot.direction == "EAST")
					@toy_robot.direction = "SOUTH"
				elsif (direction == "left") && (@toy_robot.direction == "WEST")
					@toy_robot.direction = "SOUTH"
				elsif (direction == "right") && (@toy_robot.direction == "WEST")
					@toy_robot.direction = "NORTH"
			end
		else
			View.new.error("You need to first PLACE")
		end
	end

	# Reports the robots current position to the view
	def report
		toy_robot = @toy_robot
		View.new.display(toy_robot)
	end

	private

	# Validates if input is an integer
	def is_integer?(int)
		int.to_i.to_s == int
	end

	# Validates if command is valid
	# PLACE must be the first command executed
	def valid_command?
		@toy_robot.on_table
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
		invalid_position_1 = (@toy_robot.position_x == @tabletop.dimension) && (@toy_robot.direction == "EAST")
		invalid_position_2 = (@toy_robot.position_x == 0) && (@toy_robot.direction == "WEST")
		invalid_position_3 = (@toy_robot.position_y == @tabletop.dimension) && (@toy_robot.direction == "NORTH")
		invalid_position_4 = (@toy_robot.position_y == 0) && (@toy_robot.direction == "SOUTH")
		valid_move = !(invalid_position_1 || invalid_position_2 || invalid_position_3 || invalid_position_4)
	end
end

 # Controllers role is to execute the code of a user action 
 # (understand what the user wants to do and implement those actions)
 # - co-ordinates everything to complete the user action
 
require_relative 'view'

class Controller

	def initialize(toy_robot)
		@toy_robot = toy_robot
	end

	def place(x,y,f)
		@toy_robot.position_x = x
		@toy_robot.position_y = y
		@toy_robot.facing = f
		@toy_robot.on_table = true
	end

	def move
		if valid_command?
			case @toy_robot.facing
			when "north" then (@toy_robot.position_y += 1)
			when "south" then (@toy_robot.position_y -= 1)
			when "east" then (@toy_robot.position_x += 1)
			when "west" then (@toy_robot.position_x -= 1)
			end
		else
			View.new.error("Oops, you need to PLACE")
		end
	end

	def rotate(direction)
		if valid_command?
			if (direction == "left") && (@toy_robot.facing == "north")
				@toy_robot.facing = "west"
				elsif (direction == "right") && (@toy_robot.facing == "north")
					@toy_robot.facing = "east"
				elsif (direction == "left") && (@toy_robot.facing == "south")
					@toy_robot.facing = "east"
				elsif (direction == "right") && (@toy_robot.facing == "south")
					@toy_robot.facing = "west"
				elsif (direction == "left") && (@toy_robot.facing == "east")
					@toy_robot.facing = "north"
				elsif (direction == "right") && (@toy_robot.facing == "east")
					@toy_robot.facing = "south"
				elsif (direction == "left") && (@toy_robot.facing == "west")
					@toy_robot.facing = "south"
				elsif (direction == "right") && (@toy_robot.facing == "west")
					@toy_robot.facing = "north"
			end
		else
			View.new.error("Oops, you need to PLACE")
		end
	end

	def report
		toy_robot = @toy_robot
		View.new.display(toy_robot)
	end

	def place_details
		response = View.new.ask_for_place_details
		x = response.split(",")[0]
		y = response.split(",")[1]
		f = response.split(",")[2]
		valid_directions = %w(north east south west)
		if is_integer?(x) && is_integer?(y) && valid_directions.include?(f.downcase)
			place(x.to_i,y.to_i,f)
		else
			View.new.error("Oops, '#{response}' is an invalid place command")
		end
	end

	def is_integer?(int)
		int.to_i.to_s == int
	end

	def valid_command?
		@toy_robot.on_table
		#TODO: add falling off table logic
	end

end

# USER ACTIONS

# LEFT / RIGHT
# * LEFT and RIGHT will rotate the robot 90 degrees in the specified 
# direction without changing the position of the robot.
# * A robot that is not on the table can choose the ignore the MOVE, 
# LEFT, RIGHT and REPORT commands.

# REPORT
# * REPORT will announce the X,Y and F of the robot. This can be in 
# any form, but standard output is sufficient.
# * A robot that is not on the table can choose the ignore the MOVE, 
# LEFT, RIGHT and REPORT commands.

# PLACE X,Y,F
# * PLACE will put the toy robot on the table in position X,Y and 
# facing NORTH, SOUTH, EAST or WEST.
# * The origin (0,0) can be considered to be the SOUTH WEST most 
# corner. <— i.e. bottom left
# * The first valid command to the robot is a PLACE command, after 
# that, any sequence of commands may be issued, in any order, 
# including another PLACE command. The application should discard 
# all commands in the sequence until a valid PLACE command has been 
# executed.

# MOVE
# * MOVE will move the toy robot one unit forward in the direction 
# it is currently facing.
# * A robot that is not on the table can choose the ignore the MOVE, 
# LEFT, RIGHT and REPORT commands.

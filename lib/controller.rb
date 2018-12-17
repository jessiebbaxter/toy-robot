require_relative 'view'

class Controller
	def initialize(toy_robot, tabletop)
		@toy_robot = toy_robot
		@tabletop = tabletop
	end

	def place(x,y,f)
		if @tabletop.dimension >= x && @tabletop.dimension >= y
			@toy_robot.position_x = x
			@toy_robot.position_y = y
			@toy_robot.facing = f
			@toy_robot.on_table = true
		else
			View.new.error("Oops, that PLACE is invalid")
		end
	end

	def move
		if valid_command?
			if (@toy_robot.position_x < @tabletop.dimension) && (@toy_robot.position_y < @tabletop.dimension)
				case @toy_robot.facing
				when "north" then (@toy_robot.position_y += 1)
				when "south" then (@toy_robot.position_y -= 1)
				when "east" then (@toy_robot.position_x += 1)
				when "west" then (@toy_robot.position_x -= 1)
				end
			else
				View.new.error("Oops, that MOVE is invalid")
			end
		else
			View.new.error("Oops, you need to first PLACE")
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
			View.new.error("Oops, you need to first PLACE")
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

	private

	def is_integer?(int)
		int.to_i.to_s == int
	end

	def valid_command?
		@toy_robot.on_table
	end

end

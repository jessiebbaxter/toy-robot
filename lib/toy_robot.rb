require 'pry'

class ToyRobot
	attr_accessor :position_x, :position_y, :direction, :on_table

	def initialize(attributes = {})
		@position_x = attributes[:position_x]
		@position_y = attributes[:position_y]
		@direction = attributes[:direction]
		@on_table = attributes[:on_table] || false
	end

	def update_position(toy_robot)
		case toy_robot.direction
		when 'NORTH' then (toy_robot.position_y += 1)
		when 'SOUTH' then (toy_robot.position_y -= 1)
		when 'EAST' then (toy_robot.position_x += 1)
		when 'WEST' then (toy_robot.position_x -= 1)
		end
	end
end
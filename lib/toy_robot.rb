class ToyRobot
	attr_accessor :position_x, :position_y, :direction, :on_table

	def initialize(attributes = {})
		@position_x = attributes[:position_x]
		@position_y = attributes[:position_y]
		@direction = attributes[:direction]
		@on_table = attributes[:on_table] || false
	end
end
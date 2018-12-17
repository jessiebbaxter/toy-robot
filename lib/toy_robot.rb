class ToyRobot
	attr_accessor :position_x, :position_y, :facing, :on_table

	def initialize(attributes = {})
		@position_x = attributes[:position_x]
		@position_y = attributes[:position_y]
		@facing = attributes[:facing]
		@on_table = attributes[:on_table] || false
	end
end
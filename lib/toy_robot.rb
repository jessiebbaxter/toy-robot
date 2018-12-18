class ToyRobot
  attr_accessor :x_position, :y_position, :direction, :on_table

  def initialize(attributes = {})
    @position_x = attributes[:x_position]
    @position_y = attributes[:y_position]
    @direction = attributes[:direction]
    @on_table = attributes[:on_table] || false
  end
end
class ToyRobot
  attr_accessor :x_position, :y_position, :direction, :on_table

  def initialize(attributes = {})
    @x_position = attributes[:x_position]
    @y_position = attributes[:y_position]
    @direction = attributes[:direction]
    @on_table = attributes[:on_table] || false
  end

  def current_position
    "#{@x_position},#{@y_position},#{@direction}"
  end
end
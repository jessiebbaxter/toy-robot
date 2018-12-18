class ToyRobot
  attr_accessor :x_position, :y_position, :direction, :on_table

  def initialize(attributes = {})
    @x_position = attributes[:x_position]
    @y_position = attributes[:y_position]
    @direction = attributes[:direction]
    @on_table = attributes[:on_table] || false
  end

  # Returns the current position of the robot in readable form
  def current_position
    "#{@x_position},#{@y_position},#{@direction}"
  end

  # Sets new position of toy robot
  def set_new_position(x_pos, y_pos, dir)
    @x_position = x_pos
    @y_position = y_pos
    @direction = dir
    @on_table = true
  end

  # Moves position of toy robot 1 unit forward
  def move_forward
    case @direction
    when 'NORTH' then (@y_position += 1)
    when 'SOUTH' then (@y_position -= 1)
    when 'EAST' then (@x_position += 1)
    when 'WEST' then (@x_position -= 1)
    end
  end

  # Updates direction of toy robot
  def update_direction(new_direction)
    directions = %w[NORTH EAST SOUTH WEST].freeze
    case new_direction
    when 'left'
      @direction = directions[(directions.index(@direction) - 1) % 4]
    when 'right'
      @direction = directions[(directions.index(@direction) + 1) % 4]
    end
  end
end
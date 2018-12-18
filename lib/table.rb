class Table
  attr_reader :dimension

  def initialize(attributes = {})
    # The table is a square.
    # Table size: dimension x dimension
    @dimension = attributes[:dimension]
  end

  # Checks if place is valid
  # Coordinates x and y can't be negative and can't be larger than table size
  def valid_place?(x_position, y_position)
    x_position.between?(0, @dimension) &&
      y_position.between?(0, @dimension)
  end

  # Checks if move is valid
  # Move can not result in coordinates x and y being negative or larger than table size
  # Example of move that would be invalid (return false): x_position = 5 && direction = 'EAST'
  def valid_move?(robot)
    x_pos = robot.x_position
    y_pos = robot.y_position
    dir = robot.direction
    invalid_east_move = (x_pos == @dimension) && (dir == 'EAST')
    invalid_west_move = x_pos.zero? && (dir == 'WEST')
    invalid_north_move = (y_pos == @dimension) && (dir == 'NORTH')
    invalid_south_move = y_pos.zero? && (dir == 'SOUTH')
    !(invalid_east_move || invalid_west_move || invalid_north_move || invalid_south_move)
  end
end
require_relative 'robot'
require_relative 'table'
require_relative 'controller'
require_relative 'router'

# initializes a new 5x5 table, a new robot, a new controller and a new router
table = Table.new(dimension: 5)
robot = Robot.new
controller = Controller.new(robot, table)
router = Router.new(controller)

# Start the app
router.run
require_relative 'toy_robot'
require_relative 'table'
require_relative 'controller'
require_relative 'router'

# initializes a new 5x5 table, a new robot, a new controller and a new router
table = Table.new(dimension: 5)
toy_robot = ToyRobot.new
controller = Controller.new(toy_robot, table)
router = Router.new(controller)

# Start the app
router.run
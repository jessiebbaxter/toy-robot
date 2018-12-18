require_relative 'toy_robot'
require_relative 'tabletop'
require_relative 'controller'
require_relative 'router'

# initializes a new 5x5 tabletop, a new robot, a new controller and a new router
tabletop = Tabletop.new(dimension: 5)
toy_robot = ToyRobot.new
controller = Controller.new(toy_robot, tabletop)
router = Router.new(controller)

# Start the app
router.run
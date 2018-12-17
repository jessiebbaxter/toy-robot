require_relative 'toy_robot'
require_relative 'tabletop'
require_relative 'controller'
require_relative 'router'

toy_robot = ToyRobot.new
tabletop = Tabletop.new
controller = Controller.new(toy_robot, tabletop)
router = Router.new(controller)

# Start the app
router.run
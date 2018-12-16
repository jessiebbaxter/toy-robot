require_relative 'toy_robot'
require_relative 'controller'
require_relative 'router'

toy_robot = ToyRobot.new
controller = Controller.new(toy_robot)
router = Router.new(controller)

# Start the app
router.run
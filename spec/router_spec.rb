require_relative '../lib/toy_robot'
require_relative '../lib/tabletop'
require_relative '../lib/controller'
require_relative '../lib/router'

describe Router do
	describe '#route_action' do
		context 'PLACE command' do

      it 'places robot to given input' do
        tabletop = Tabletop.new(dimension: 5)
				toy_robot = ToyRobot.new
				controller = Controller.new(toy_robot, tabletop)
				router = Router.new(controller)
				input = 'PLACE 1,2,NORTH'

				router.route_action(input)

        expect(toy_robot.position_x).to eq(1)
        expect(toy_robot.position_y).to eq(2)
        expect(toy_robot.direction).to eq("NORTH")
      end

      it 'does not place robot if move is invalid' do
      end

      it 'does nothing if input is invalid' do
      end
    end
	end
end

#Is the above the routers role? 
#The routers roles is to pass it to the correct method in the controller
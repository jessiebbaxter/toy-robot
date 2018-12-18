require_relative '../lib/robot'
require_relative '../lib/table'
require_relative '../lib/controller'
require_relative '../lib/router'
require_relative '../lib/view'

describe Controller do
  let(:robot) { Robot.new }
  let(:table) { Table.new(dimension: 5) }
  let(:controller) { Controller.new(robot, table) }
  let(:router) { Router.new(controller) }
  let(:view) { View.new }

	describe '#initialize' do
	  
    it 'should store the Robot in an instance variable' do
      expect(controller.instance_variable_get(:@robot)).to be_a Robot
  	end

  	it 'should store the Table in an instance variable' do
      expect(controller.instance_variable_get(:@table)).to be_a Table
  	end
  end

  describe '#place' do
    it 'places robot to given input' do
      input = 'PLACE 1,2,NORTH'

      router.route_action(input)

      expect(robot.x_position).to eq(1)
      expect(robot.y_position).to eq(2)
      expect(robot.direction).to eq('NORTH')
    end

    it 'does not place robot if place input is invalid' do
      input = "PLACE 5,7,NORTH"

      router.route_action(input)

      expect(robot.x_position).to eq(nil)
      expect(robot.y_position).to eq(nil)
      expect(robot.direction).to eq(nil)        
    end
  end

  describe '#move' do
    it 'moves robot' do
      input = 'MOVE'
      robot.x_position = 2
      robot.y_position = 3
      robot.direction = 'SOUTH'
      robot.on_table = true

      router.route_action(input)

      expect(robot.x_position).to eq(2)
      expect(robot.y_position).to eq(2)
      expect(robot.direction).to eq('SOUTH')  
    end

    it 'does not move robot if it has not been placed' do
      input = 'MOVE'

      expect { router.route_action(input)}.to output("You need to first place\n\n").to_stdout
    end

    it 'does not move robot if move is invalid' do
      input = 'MOVE'
      robot.x_position = 4
      robot.y_position = 0
      robot.direction = 'SOUTH'

      router.route_action(input)

      expect(robot.x_position).to eq(4)
      expect(robot.y_position).to eq(0)
      expect(robot.direction).to eq('SOUTH')
    end
  end

  describe '#rotate' do
    it 'rotates robot left when facing east' do
      input = 'LEFT'
      robot.direction = 'EAST'
      robot.on_table = true

      router.route_action(input)

      expect(robot.direction).to eq('NORTH')
    end

    it 'rotates robot right when facing south' do
      input = 'RIGHT'
      robot.direction = 'SOUTH'
      robot.on_table = true

      router.route_action(input)

      expect(robot.direction).to eq('WEST')
    end

    it 'rotates robot right when facing west' do
      input = 'RIGHT'
      robot.direction = 'WEST'
      robot.on_table = true

      router.route_action(input)

      expect(robot.direction).to eq('NORTH')
    end

    it 'does not rotate robot if it has not been placed' do
      input = 'RIGHT'

      router.route_action(input)

      expect(robot.direction).to eq(nil)
    end
  end

  describe '#report' do
    it 'reports the robots position' do
      input = 'REPORT'
      robot.x_position = 1
      robot.y_position = 2
      robot.direction = 'WEST'
      robot.on_table = true

      expect { router.route_action(input)}.to output("Your current position is: 1,2,WEST\n\n").to_stdout
    end

    it 'does not report if it has not been placed' do
      input = 'REPORT'
      robot.x_position = 1
      robot.y_position = 2
      robot.direction = 'WEST'

      expect { router.route_action(input)}.to output("Your robot has not been placed\n\n").to_stdout
    end
  end
end
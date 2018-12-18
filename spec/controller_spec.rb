require_relative '../lib/toy_robot'
require_relative '../lib/tabletop'
require_relative '../lib/controller'
require_relative '../lib/router'
require_relative '../lib/view'

describe Controller do
  let(:toy_robot) { ToyRobot.new }
  let(:tabletop) { Tabletop.new(dimension: 5) }
  let(:controller) { Controller.new(toy_robot, tabletop) }
  let(:router) { Router.new(controller) }
  let(:view) { View.new }

	describe '#initialize' do
	  
    it 'should store the ToyRobot in an instance variable' do
      expect(controller.instance_variable_get(:@toy_robot)).to be_a ToyRobot
  	end

  	it 'should store the Tabletop in an instance variable' do
      expect(controller.instance_variable_get(:@tabletop)).to be_a Tabletop
  	end
  end

  describe '#place' do
    it 'places robot to given input' do
      input = 'PLACE 1,2,NORTH'

      router.route_action(input)

      expect(toy_robot.x_position).to eq(1)
      expect(toy_robot.y_position).to eq(2)
      expect(toy_robot.direction).to eq('NORTH')
    end

    it 'does not place robot if place input is invalid' do
      input = "PLACE 5,7,NORTH"

      router.route_action(input)

      expect(toy_robot.x_position).to eq(nil)
      expect(toy_robot.y_position).to eq(nil)
      expect(toy_robot.direction).to eq(nil)        
    end
  end

  describe '#move' do
    it 'moves robot' do
      input = 'MOVE'
      toy_robot.x_position = 2
      toy_robot.y_position = 3
      toy_robot.direction = 'SOUTH'
      toy_robot.on_table = true

      router.route_action(input)

      expect(toy_robot.x_position).to eq(2)
      expect(toy_robot.y_position).to eq(2)
      expect(toy_robot.direction).to eq('SOUTH')  
    end

    it 'does not move robot if it has not been placed' do
      input = 'MOVE'
      toy_robot.x_position = 4
      toy_robot.y_position = 1
      toy_robot.direction = 'EAST'

      router.route_action(input)

      expect(toy_robot.x_position).to eq(4)
      expect(toy_robot.y_position).to eq(1)
      expect(toy_robot.direction).to eq('EAST')  
    end

    it 'does not move robot if move is invalid' do
      input = 'MOVE'
      toy_robot.x_position = 4
      toy_robot.y_position = 0
      toy_robot.direction = 'SOUTH'

      router.route_action(input)

      expect(toy_robot.x_position).to eq(4)
      expect(toy_robot.y_position).to eq(0)
      expect(toy_robot.direction).to eq('SOUTH')
    end
  end

  describe '#rotate' do
    it 'rotates robot left when facing east' do
      input = 'LEFT'
      toy_robot.direction = 'EAST'
      toy_robot.on_table = true

      router.route_action(input)

      expect(toy_robot.direction).to eq('NORTH')
    end

    it 'rotates robot right when facing south' do
      input = 'RIGHT'
      toy_robot.direction = 'SOUTH'
      toy_robot.on_table = true

      router.route_action(input)

      expect(toy_robot.direction).to eq('WEST')
    end

    it 'does not rotate if move it has not been placed' do
      input = 'RIGHT'

      router.route_action(input)

      expect(toy_robot.direction).to eq(nil)
    end
  end
end
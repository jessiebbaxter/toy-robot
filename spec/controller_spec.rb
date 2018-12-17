require_relative '../lib/toy_robot'
require_relative '../lib/tabletop'
require_relative '../lib/controller'
require_relative '../lib/view'

describe Controller do

	describe '#initialize' do
	  let(:toy_robot) { ToyRobot.new }
	  let(:tabletop) { Tabletop.new }
	  let(:controller) { Controller.new(toy_robot, tabletop) }

    it 'should store the ToyRobot in an instance variable' do
      expect(controller.instance_variable_get(:@toy_robot)).to be_a ToyRobot
  	end

  	it 'should store the Tabletop in an instance variable' do
      expect(controller.instance_variable_get(:@tabletop)).to be_a Tabletop
  	end
  end

  describe '#place_details' do
    it 'should return an error if input is not the correct format' do
      #TODO
    end
  end
end
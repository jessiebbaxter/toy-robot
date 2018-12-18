describe Robot do
  let(:robot) { Robot.new(x_position: 2, y_position: 3, direction: 'SOUTH') }

	describe '#current_position' do
	  
    it 'returns the current position of the robot in readable form' do      
      expect(robot.current_position).to eq("2,3,SOUTH")
  	end
  end

  describe '#set_new_position' do

    it 'updates the position of the robot' do
      robot.set_new_position(3,4,'EAST')

      expect(robot.x_position).to eq(3)
      expect(robot.y_position).to eq(4)
      expect(robot.direction).to eq('EAST')
      expect(robot.on_table).to eq(true)
    end
  end

  describe '#move_forward' do

    it 'moves position of robot forward 1 unit' do
      robot.move_forward

      expect(robot.x_position).to eq(2)
      expect(robot.y_position).to eq(2)
      expect(robot.direction).to eq('SOUTH')
    end
  end

  describe '#update_direction' do
    it 'updates direction of robot' do
      robot.update_direction('left')

      expect(robot.x_position).to eq(2)
      expect(robot.y_position).to eq(3)
      expect(robot.direction).to eq('EAST')
    end
  end
end
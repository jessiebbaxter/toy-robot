describe Table do
	let(:table) { Table.new(dimension: 5) }

	describe '#valid_place?' do
		it 'returns true if the place input is valid' do

			expect(table.valid_place?(1,2)).to eq(true)
		end

		it 'returns false if the place input is invalid' do

			expect(table.valid_place?(6,4)).to eq(false)
		end
	end

	describe '#valid_move?' do
		it 'returns true if the move is valid' do
			robot = Robot.new(x_position: 3, y_position: 1, direction: 'EAST')
			
			expect(table.valid_move?(robot)).to eq(true)
		end

		it 'returns false if the move is not valid' do
			robot = Robot.new(x_position: 3, y_position: 0, direction: 'SOUTH')
			
			expect(table.valid_move?(robot)).to eq(false)
		end
	end
end
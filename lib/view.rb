class View
	def display(toy_robot)
		puts "Your robots current position is (#{toy_robot.position_x}, 
		#{toy_robot.position_y}, #{toy_robot.facing})"
	end

	def ask_for_place_details
		puts "What position and direction would you like to place your robot? e.g. '0,1,NORTH'"
		response = gets.chomp
	end
end
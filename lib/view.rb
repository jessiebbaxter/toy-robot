# Role is to interacts with the user - displays/retrieves information 

class View
	def display(toy_robot)
		puts "Your toy robots current position is:" 
		puts "#{toy_robot.position_x},#{toy_robot.position_y},#{toy_robot.facing}"
		puts ""
	end

	def ask_for_place_details
		puts "What position and direction? For example, '0,1,NORTH'"
		response = gets.chomp
	end

	def invalid_place_details(response)
		puts "Oops, '#{response}' is an invalid command"
		puts ""
	end
end
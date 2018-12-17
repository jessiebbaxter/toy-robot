class View
	def display(toy_robot)
		if toy_robot.on_table == false
			puts "Your robot has not been PLACED"
			puts ""
		else
			puts "Your current position is:" 
			puts "#{toy_robot.position_x},#{toy_robot.position_y},#{toy_robot.direction}"
			puts ""
		end
	end

	def ask_for_position_details
		puts "What position and direction? For example, '0,1,NORTH'"
		print "> "
		response = gets.chomp
	end

	def error(error_message)
		puts "#{error_message}"
		puts ""
	end
end
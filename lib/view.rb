class View
  def display_position(robot)
    if robot.on_table == false
      puts "Your robot has not been placed"
    else
      puts "Your current position is: #{robot.current_position}"
    end
    puts ""
  end

  def error(error_message)
    puts error_message.to_s
    puts ""
  end
end
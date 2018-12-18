class View
  def display_position(toy_robot)
    if toy_robot.on_table == false
      puts "Your robot has not been PLACED"
    else
      puts "Your current position is: #{toy_robot.current_position}"
    end
    puts ""
  end

  def error(error_message)
    puts error_message.to_s
    puts ""
  end
end
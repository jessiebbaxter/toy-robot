class View
  def display(toy_robot)
    if toy_robot.on_table == false
      puts "Your robot has not been PLACED"
    else
      puts "Your current position is:"
      puts "#{toy_robot.position_x},#{toy_robot.position_y},#{toy_robot.direction}"
    end
    puts ""
  end

  def error(error_message)
    puts error_message.to_s
    puts ""
  end
end
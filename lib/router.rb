class Router
  def initialize(controller)
    @controller = controller
    @running = true
  end

  # Displays simulator interface and retrieves user input
  def run
    puts "---------------------------------------"
    puts "Welcome to your Toy Robot Simulator! 🤖"
    puts "---------------------------------------"
    puts ""
    puts "Please input your command (EXIT to quit):"
    puts ""
    while @running
      print "> "
      action = gets.chomp
      route_action(action)
    end
  end

  # Routes user input to appropriate method in the controller
  def route_action(action)
    case action
    when pattern = /PLACE\s(?<position_x>\d+),(?<position_y>\d+),(?<direction>NORTH|SOUTH|EAST|WEST)/
      then
      match_data = action.match(pattern)
      @controller.place(match_data[:position_x].to_i,
                        match_data[:position_y].to_i, match_data[:direction])
    when 'MOVE' then @controller.move
    when 'LEFT' then @controller.rotate('left')
    when 'RIGHT' then @controller.rotate('right')
    when 'REPORT' then @controller.report
    when 'EXIT' then stop
    else
      puts "Invalid command"
      puts ""
    end
  end

  def stop
    @running = false
  end
end
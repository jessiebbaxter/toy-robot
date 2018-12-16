# Role is to dispatch user intent to the right method in the 
# right controller
class Router
  def initialize(controller)
    @controller = controller
    @running = true
  end

  def run
    puts "Welcome to your Toy Robot Simulator!"
    puts "           --           "

    while @running
      display_commands
      action = gets.chomp.to_i
      print `clear`
      route_action(action)
    end
  end

  private

  def route_action(action)
    case action
    when 1 then @controller.place
    when 2 then @controller.move
    when 3 then @controller.rotate("left")
    when 4 then @controller.rotate("right")
    when 5 then @controller.report
    when 0 then stop
    else
      puts "Please press 1, 2, 3, 4, 5 or 0"
    end
  end

  def stop
    @running = false
  end

  def display_commands
    puts ""
    puts "What would you like to do next?"
    puts "1 - PLACE"
    puts "2 - MOVE"
    puts "3 - LEFT"
    puts "4 - RIGHT"
    puts "5 - REPORT"
    puts "0 - EXIT"
  end
end
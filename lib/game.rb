require 'locavore'

class Game
  def initialize window_manager
    @window_manager = window_manager
  end

  def place_robot_at row, column
    @robot_position = [row, column]
  end

  def start
    print_robot '#'
    @window_manager.print Position.new(24, 0), "Find kitten!"
  end

  def move_left
    print_robot ' '
    @robot_position[1] -= 1
    print_robot '#'
  end

  private

  def print_robot display
    @window_manager.print Position.new(@robot_position[0], @robot_position[1]), display
  end
end

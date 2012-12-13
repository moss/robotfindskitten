require 'locavore'

class Game
  def initialize window_manager
    @window_manager = window_manager
  end

  def place_robot_at row, column
    @robot_position = Position.new(row, column)
  end

  def start
    print_robot '#'
    @window_manager.print Position.new(24, 0), "Find kitten!"
  end

  def move_left
    move_robot :left
  end

  def move_right
    move_robot :right
  end

  def move_up
    move_robot :up
  end

  def move_down
    move_robot :down
  end

  private

  def move_robot direction
    print_robot ' '
    @robot_position = @robot_position.send(direction)
    print_robot '#'
  end

  def print_robot display
    @window_manager.print @robot_position, display
  end
end

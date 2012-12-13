require 'locavore'

class NonKittenItem
  attr_reader :display, :description

  def initialize display, description
    @display = display
    @description = description
  end
end

class Game
  def initialize window_manager
    @window_manager = window_manager
    @non_kitten_items = Hash.new
  end

  def place_robot_at row, column
    @robot_position = Position.new(row, column)
  end

  def place_non_kitten_item position, item
    @non_kitten_items[position] = item
  end

  def start
    print_robot '#'
    @non_kitten_items.each {|position, item| @window_manager.print position, item.display }
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

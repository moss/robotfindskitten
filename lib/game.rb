require 'locavore'

class NonKittenItem
  attr_reader :display, :description

  def initialize display, description
    @display = display
    @description = description
  end

  def kitten?
    false
  end
end

class Kitten
  attr_reader :display

  def initialize display
    @display = display
  end

  def kitten?
    true
  end
end

class Game
  def initialize window_manager
    @window_manager = window_manager
    @items = Hash.new
  end

  def place_robot_at row, column
    @robot_position = Position.new(row, column)
  end

  def place_item position, item
    @items[position] = item
  end

  def start
    print_robot '#'
    @items.each { |position, item| @window_manager.print position, item.display }
    @window_manager.print @kitten_position, @kitten.display unless @kitten.nil?
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
    target_position = @robot_position.send(direction)
    if @items.has_key? target_position
      touch_item @items[target_position]
    else
      print_robot ' '
      @robot_position = target_position
      print_robot '#'
    end
  end

  def touch_item item
    if item.kitten?
      @window_manager.print Position.new(0, 0), "Congratulations! You found kitten!"
    else
      @window_manager.print Position.new(0, 0), item.description
    end
  end

  def print_robot display
    @window_manager.print @robot_position, display
  end
end

class Game
  def initialize window_manager
    @window_manager = window_manager
  end

  def place_robot_at row, column
    @robot_position = [row, column]
  end

  def start
    @window_manager.print @robot_position[0], @robot_position[1], "#"
    @window_manager.print 24, 0, "Find kitten!"
  end
end

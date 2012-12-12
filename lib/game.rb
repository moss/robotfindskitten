class Game
  def initialize window_manager
    @window_manager = window_manager
  end

  def start
    @window_manager.print 24, 0, "Find kitten!"
  end
end

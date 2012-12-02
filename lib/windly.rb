require 'rbcurse'
require 'logger'


class WindowManager
  def self.open logger = Logger.new(STDOUT)
    begin
      $log = logger
      $log.level = Logger::WARN
      VER::start_ncurses
      Ncurses.curs_set 0
      window = VER::Window.root_window
      window_manager = WindowManager.new(window)
      yield window_manager
      window.destroy
    ensure
      VER::stop_ncurses
    end
  end

  def initialize window
    @window = window
  end

  def print row, column, text
    @window.printstring row, column, text, $normalcolor
  end

  def getchar
    @window.getchar
  end
end


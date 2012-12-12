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

class FakeWindowManager
  def initialize row_count = 25, column_count = 80
    @rows = (1..row_count).collect { ' ' * column_count }
    @input_queue = []
  end

  def print row, column, text
    @rows[row][column, text.length] = text
  end

  def getchar
    raise "No test input provided!" if @input_queue.empty?
    @input_queue.shift
  end

  def char_at row, column
    @rows[row][column]
  end

  def row row
    @rows[row]
  end

  def type key
    @input_queue << key
  end
end
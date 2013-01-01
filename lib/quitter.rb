class Quitter
  def initialize
    @running = true
  end

  def quit
    @running = false
  end

  def running?
    @running
  end
end
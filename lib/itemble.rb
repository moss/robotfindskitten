class Itemble
  def initialize input
    @items = input.readlines.collect {|line| line.strip }
  end

  def pick count
    @items.shuffle.first(count)
  end
end
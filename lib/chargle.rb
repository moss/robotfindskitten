class Chargle
  def initialize
    @actions = Hash.new{|h, k| h[k] = proc{} }
  end

  def on_press *chars, &block
    chars.each {|char| @actions[char.ord] = block }
  end

  def pressed char
    @actions[char.ord].call(char.chr)
  end
end

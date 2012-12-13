class Position
  attr_reader :row, :column

  def initialize row, column
    @row = row
    @column = column
  end

  def left
    Position.new(row, column - 1)
  end

  def right
    Position.new(row, column + 1)
  end

  def up
    Position.new(row - 1, column)
  end

  def down
    Position.new(row + 1, column)
  end

  def == other
    self.row == other.row && self.column == other.column
  end

  def to_s
    "(row: #@row, column: #@column)"
  end
end
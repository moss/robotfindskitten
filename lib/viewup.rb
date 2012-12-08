class Viewup
  def initialize mappic, windly
    @mappic = mappic
    @windly = windly
  end

  def update
    0.upto(24) do |row|
      0.upto(79) do |column|
        @windly.print row, column, content(row, column)
      end
    end
  end

  def content row, column
    cell = @mappic.cell(row, column)
    return ' ' if cell.nil?
    cell.appearance
  end
end
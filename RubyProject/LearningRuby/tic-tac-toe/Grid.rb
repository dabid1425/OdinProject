class Grid
  SIZE = 3
  EMPTY = '-'
  WIN_PATTERNS = [
    [[1,1],[1,2],[1,3]], [[2,1],[2,2],[2,3]], [[3,1],[3,2],[3,3]],  # rows
    [[1,1],[2,1],[3,1]], [[1,2],[2,2],[3,2]], [[1,3],[2,3],[3,3]],  # columns
    [[1,1],[2,2],[3,3]], [[1,3],[2,2],[3,1]]                        # diagonals
  ].freeze

  def initialize
    @table = Array.new(SIZE) { Array.new(SIZE, EMPTY) }
  end

  def place(row, col, symbol)
    return false unless valid_move?(row, col)

    @table[row - 1][col - 1] = symbol
    true
  end

  def winner?
    WIN_PATTERNS.any? do |pattern|
      values = pattern.map { |row, col| @table[row - 1][col - 1] }
      values.uniq.length == 1 && values.first != EMPTY
    end
  end

  def full?
    @table.all? { |row| row.none? { |cell| cell == EMPTY } }
  end

  def print_table
    system('clear')
    puts "#{@table[0][0]}|#{@table[0][1]}|#{@table[0][2]}"
    puts "#{@table[1][0]}|#{@table[1][1]}|#{@table[1][2]}"
    puts "#{@table[2][0]}|#{@table[2][1]}|#{@table[2][2]}"
  end

  private

  def valid_move?(row, col)
    row.between?(1, SIZE) && col.between?(1, SIZE) && @table[row - 1][col - 1] == EMPTY
  end
end

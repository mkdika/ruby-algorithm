=begin
Legends:
-1    --> bomb
0     --> no bombs surrounding
n > 0 --> numbers of bombs surrounding
=end

class MineSweeper
  attr_reader :num_row, :num_col, :matrix, :num_bomb
  def initialize(num_row, num_col)
    @num_row = num_row
    @num_col = num_col
    @matrix = Array.new(@num_row){Array.new(@num_col, 0)}
    @num_bomb = 0
  end

  def generate(bombs)
    bombs.each do |b|
      update_bomb_and_surrounding(b[0], b[1])
    end
    @num_bomb = bombs.size
    return matrix
  end

  def generate_and_print(bombs)
    generate(bombs)
    print
  end

  def random_bombs(n)
    n = ((num_row * num_col) / 2) if n > ((num_row * num_col) / 2)
    h = {}
    i = 0
    while i < n
      x = rand(0..num_row-1)
      y = rand(0..num_col-1)
      unless h.key? "#{x}#{y}"
        h["#{x}#{y}"] = [x, y]
        i += 1
      end
    end
    h.map { |k,v| v }
  end

  private

  def print
    line = "\u2550" * ( (matrix[0].size * 2)+(matrix[0].size) + 1)
    puts
    puts "\tSize: #{num_row} x #{num_col} | Number of bomb: #{num_bomb}"
    puts "\t\u2554" + line + "\u2557"
    puts matrix.map { |x| "\t\u2551 #{x.map{ |s| s.to_s.rjust(2) }.join(' ')} \u2551" }
    puts "\t\u255A" + line + "\u255D"
    puts
  end

  def update_bomb_and_surrounding(row, col)
    matrix[row][col] = -1
    for i in (row-1..row+1)
      for j in (col-1..col+1)
        if 0 <= i && i < num_row && 0 <= j && j < num_col && matrix[i][j] != -1
          matrix[i][j] += 1
        end
      end
    end
  end
end

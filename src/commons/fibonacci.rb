# compare 3 Fibonacci algorithm
require 'benchmark'

class NaiveFibs
  def run(n)
    return 1 if n == 1 || n == 2
    run(n - 1) + run(n - 2)
  end
end

class MemoizationRecursiveFibs
  def initialize
    @cache = []
  end

  def run(n)
    return 1 if n == 1 || n == 2
    return @cache[n] unless @cache[n].nil?
    r = run(n - 1) + run(n - 2)
    @cache[n] = r
    return r
  end
end

class MemoizationIterativeFibs
  def initialize
    @cache = []
  end

  def run(n)
    return 1 if n == 1 || n == 2
    @cache[1] = 1
    @cache[2] = 1
    (3..n).each do |i|
      @cache[i] = @cache[i-1].to_i + @cache[i-2].to_i
    end
    @cache[n]
  end
end


n = 50
puts "Ruby Fibonacci algorithms comparisson, N=#{n}"

# NOTE: commented due to very slow with large number
# time1 = Benchmark.measure {
#   result = NaiveFibs.new.run(n)
#   puts "Naive recursive\n\tResult: #{result}"
# }
# puts "\tExecute in #{time1}"

time2 = Benchmark.measure {
  result = MemoizationRecursiveFibs.new.run(n) 
  puts "Memoization recursive\n\tResult: #{result}"
}
puts "\tExecute in #{time2}"

time3 = Benchmark.measure {
  result = MemoizationIterativeFibs.new.run(n) 
  puts "Memoization iterative\n\tResult: #{result}"
}
puts "\tExecute in #{time3}"

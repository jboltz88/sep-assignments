require 'benchmark'
require './algorithms/01-intro-to-algorithms/fibonnaci_iterative.rb'

class FibRecursive
  def fib(n)
    if (n == 0)
      return 0
    elsif (n == 1)
      return 1
    else
      return fib(n-1) + fib(n-2)
    end
  end
end

recursive = FibRecursive.new
iterative = FibIterative.new

puts "Recursive:"
puts Benchmark.measure {
  recursive.fib(20)
}
puts "Iterative:"
puts Benchmark.measure {
  iterative.fib(20)
}

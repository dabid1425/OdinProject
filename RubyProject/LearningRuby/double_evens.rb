# frozen_string_literal: true
def double_evens(numbers)
  raise ArgumentError, "prices must be an Array" unless numbers.is_a?(Array)
  raise ArgumentError, "all prices must be numeric" unless numbers.all? { |p| p.is_a?(Numeric) }
  numbers.select { |n| n % 2 == 0 }.map { |n| n * 2 }
end

def try_pick(arg)
  result = double_evens(arg)
  puts "#{arg.inspect} => #{result.inspect}"
rescue ArgumentError => e
  puts "#{arg.inspect} => ArgumentError: #{e.message}"
end

try_pick([1,2,3,4,5,6]) # => [4, 8, 12]
def bubble_sort(input)
  raise ArgumentError, "prices must be an Array" unless input.is_a?(Array)
  raise ArgumentError, "prices must have at least 2 elements" if input.length < 2
  raise ArgumentError, "all prices must be numeric" unless input.all? { |p| p.is_a?(Numeric) }
  array = input.map { |x| x }
  swap = true
  while swap
    swap = false
    (array.length - 1).times do |x|
      if array[x] > array[x+1]
        array[x], array[x+1] = array[x+1], array[x]
        swap = true
      end
    end
  end
  array
end

def try_sort(arg)
  result = bubble_sort(arg)
  puts "#{arg.inspect} => #{result.inspect}"
rescue ArgumentError => e
  puts "#{arg.inspect} => ArgumentError: #{e.message}"
end

try_sort([4, 3, 78, 2, 0, 2])

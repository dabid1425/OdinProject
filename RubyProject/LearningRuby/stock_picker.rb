def stock_picker(prices)
  raise ArgumentError, "prices must be an Array" unless prices.is_a?(Array)
  raise ArgumentError, "prices must have at least 2 elements" if prices.length < 2
  raise ArgumentError, "all prices must be numeric" unless prices.all? { |p| p.is_a?(Numeric) }

  first_index  = prices.each_index.first
  second_index = first_index.next
  min_index    = first_index
  best_buy     = first_index
  best_sell    = second_index
  best_profit  = prices[second_index] - prices[first_index]

  prices.each_with_index do |price, day|
    next if day == first_index

    profit = price - prices[min_index]

    if profit > best_profit
      best_profit = profit
      best_buy = min_index
      best_sell = day
    end

    if price < prices[min_index]
      min_index = day
    end
  end

  return nil if best_profit <= 0

  [best_buy, best_sell]
end

def try_pick(arg)
  result = stock_picker(arg)
  puts "#{arg.inspect} => #{result.inspect}"
rescue ArgumentError => e
  puts "#{arg.inspect} => ArgumentError: #{e.message}"
end

try_pick([17,3,6,9,15,8,6,1,10])
try_pick([10, 9, 8, 7])
try_pick([5])
try_pick("not an array")
try_pick([5, "a", 3])

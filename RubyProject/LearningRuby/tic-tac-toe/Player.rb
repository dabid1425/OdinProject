class Player
  def initialize(name, symbol)
    @name = name
    @symbol = symbol
    @turn = false
  end
  # getters
  attr_reader :symbol, :name
  # getter and setter
  attr_accessor :turn
end
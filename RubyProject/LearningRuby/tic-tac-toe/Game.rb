require_relative 'Player'
require_relative 'Grid'

class Game
  def initialize
    @grid = Grid.new
    @player_one = Player.new(get_name('Player 1'), 'X')
    @player_two = Player.new(get_name('Player 2'), 'O')
    @current_player = @player_one
  end

  def play
    loop do
      @grid.print_table
      row, col = get_move
      unless @grid.place(row, col, @current_player.symbol)
        puts 'That spot is taken or invalid move, try again.'
        next
      end
      if @grid.winner?
        @grid.print_table
        puts "#{@current_player.name} wins!"
        break
      end
      if @grid.full?
        @grid.print_table
        puts "It's a draw!"
        break
      end
      switch_turn
    end
  rescue Interrupt
    puts "\nGame quit."
  end

  private

  def get_name(prompt)
    loop do
      print "#{prompt}, enter your name: "
      name = gets.chomp
      return name if name.match?(/[a-z]/i)

      puts 'Name must contain at least one letter.'
    end
  end

  def get_move
    loop do
      print "#{@current_player.name} (#{@current_player.symbol}), enter row,col (1-3): "
      parts = gets.chomp.split(',')
      if parts.length == 2
        row, col = parts.map(&:strip).map(&:to_i)
        return [row, col] if row.between?(1, Grid::SIZE) && col.between?(1, Grid::SIZE)
      end
      puts "Invalid input. Enter as row,col e.g. 2,2 with each value between 1-#{Grid::SIZE}."
    end
  end

  def switch_turn
    @current_player = @current_player == @player_one ? @player_two : @player_one
  end
end

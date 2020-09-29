require 'pry'

class Player
  attr_reader :MARK, :player

  def initialize(player, pc = false)
    @player = player
    @pc = pc
    @MARK = player == 1 ? 'X' : 'O'
  end

  def self.valid_number_of_players?(number)
    number == '1' || number == '2'
  end

  def get_input
    return get_input_pc if @pc

    pos = ''
    loop do
      puts "Turn of player#{@player}:"
      puts 'Introduce position: '
      pos = gets.chomp
      puts

      break if pos.to_i >= 1 && pos.to_i <= 9

      puts 'Incorrect position, please introduce a position between 1 and 9.'
    end

    pos
  end

  private

  def get_input_pc
    rand(1..9)
  end
end

class TicTacToe
  def initialize
    @board = start_board
  end

  def draw_board
    @board.each do |row|
      print '| '
      row.each { |pos| print "#{pos} | " }
      puts "\n" + ' ' + '-' * 11
    end
    puts
  end

  def free_position?(pos)
    @board.any? { |row| row.any? { |value| value == pos.to_i } }
  end

  def update_board(pos, player)
    @board.map! do |row|
      row.map! do |value|
        if value == pos.to_i
          player.MARK
        else
          value
        end
      end
    end
  end

  # Check if any row, collum or diagonal has all the same mark

  def player_won?(player)
    diagonals = []
    diagonals << (0..2).map { |i| @board[i][i] }
    diagonals << (0..2).map { |i| @board[i][-i - 1] }
    if @board.any? { |row| row.all? { |value| value == player.MARK } }
      return true
    elsif @board.transpose.any? { |row| row.all? { |value| value == player.MARK } }
      return true
    elsif diagonals.any? { |row| row.all? { |value| value == player.MARK } }
      return true
    end

    false
  end

  # Check if there is a tie. Assume tie as all 9 positions marked with Xs or Os

  def draw?
    @board.all? { |row| row.all? { |value| value == 'X' || value == 'O' } }
  end

  def player_turn(pos, player)
    if free_position?(pos)
      update_board(pos, player)
      draw_board

      1
    end
  end

  private

  def start_board
    [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
  end
end

def main
  numb_players = ''

  # Ask input for number of players and check if the input is correct.

  loop do
    puts 'Set numbers of players: (1 -> Player Vs PC or 2 -> Player Vs Player'
    numb_players = gets.chomp
    break if Player.valid_number_of_players?(numb_players)

    puts 'Incorrect number of players, try again'
  end

  # Initilize board and players. If numb_players = 2 set second player as PC
  board = TicTacToe.new
  player1 = Player.new(1)
  player2 = numb_players == '1' ? Player.new(2, true) : Player.new(2)

  board.draw_board

  loop do
    loop do
      position = player1.get_input

      break unless board.player_turn(position, player1).nil?

      puts puts 'There already is a mark in that position, try again.'
    end

    if board.player_won?(player1)
      puts "player#{player1.player} won"
      break
    elsif board.draw?
      puts 'DRAW'
      break
    end

    loop do
      position = player2.get_input

      break unless board.player_turn(position, player2).nil?

      puts puts 'There already is a mark in that position, try again.'
    end

    if board.player_won?(player2)
      puts "player#{player2.player} won"
      break
    elsif board.draw?
      puts 'DRAW'
      break
    end
  end
end

main

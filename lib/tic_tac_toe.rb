
class TicTacToe
  attr_accessor :board

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

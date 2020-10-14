require_relative 'player'
require_relative 'tic_tac_toe'

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
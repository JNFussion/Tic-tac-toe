require '../lib/tic_tac_toe'
require '../lib/player'

describe 'TicTacToe' do
  describe '#player_won?' do
    describe 'row' do
      it 'return true if player 1 mark a completed row' do
        game = TicTacToe.new
        game.board[rand(0..2)] = %w[X X X]
        player = Player.new(1)
        expect(game.player_won?(player)).to eql(true)
      end

      it 'return true if player 2 mark a completed row' do
        game = TicTacToe.new
        game.board[rand(0..2)] = %w[O O O]
        player = Player.new(2)
        expect(game.player_won?(player)).to eql(true)
      end

      it "return false if player 1 didn't mark a completed row" do
        game = TicTacToe.new
        game.board[rand(0..2)] = %w[O O O]
        player = Player.new(1)
        expect(game.player_won?(player)).to eql(false)
      end

      it "return false if player 2 didn't mark a completed row" do
        game = TicTacToe.new
        game.board[rand(0..2)] = %w[X X X]
        player = Player.new(2)
        expect(game.player_won?(player)).to eql(false)
      end
    end

    describe 'column' do
      it 'return true if player 1 mark a completed column' do
        game = TicTacToe.new
        column = rand(0..1)
        game.board.map { |row| row[column] = 'X' }
        player = Player.new(1)
        expect(game.player_won?(player)).to eql(true)
      end

      it 'return true if player 2 mark a completed column' do
        game = TicTacToe.new
        column = rand(0..1)
        game.board.map { |row| row[column] = 'O' }
        player = Player.new(2)
        expect(game.player_won?(player)).to eql(true)
      end

      it "return false if player 1 didn't mark a completed column" do
        game = TicTacToe.new
        column = rand(0..1)
        game.board.map { |row| row[column] = 'O' }
        player = Player.new(1)
        expect(game.player_won?(player)).to eql(false)
      end

      it 'return false if player 2 mark a completed column' do
        game = TicTacToe.new
        column = rand(0..1)
        game.board.map { |row| row[column] = 'X' }
        player = Player.new(2)
        expect(game.player_won?(player)).to eql(false)
      end
    end
    describe 'diagonal' do
      describe 'left to right' do
        it 'return true if player 1 mark left to right diagonal' do
          game = TicTacToe.new
          game.board = game.board.each_with_index { |row, index| row[index] = 'X' }
          player = Player.new(1)
          expect(game.player_won?(player)).to eql(true)
        end

        it 'return true if player 2 mark left to right diagonal' do
          game = TicTacToe.new
          game.board = game.board.each_with_index { |row, index| row[index] = 'O' }
          player = Player.new(2)
          expect(game.player_won?(player)).to eql(true)
        end

        it "return false if player 1 didn't mark left to right diagonal" do
          game = TicTacToe.new
          game.board = game.board.each_with_index { |row, index| row[index] = 'O' }
          player = Player.new(1)
          expect(game.player_won?(player)).to eql(false)
        end

        it "return false if player 2 didn't mark left to right diagonal" do
          game = TicTacToe.new
          game.board = game.board.each_with_index { |row, index| row[index] = 'X' }
          player = Player.new(2)
          expect(game.player_won?(player)).to eql(false)
        end
      end

      describe 'right to left' do
        it 'return true if player 1 mark right to left diagonal' do
          game = TicTacToe.new
          (0..game.board.size - 1).map { |i| game.board[i][-i - 1] = 'X' }
          player = Player.new(1)
          expect(game.player_won?(player)).to eql(true)
        end

        it 'return true if player 2 mark right to left diagonal' do
          game = TicTacToe.new
          (0..game.board.size - 1).map { |i| game.board[i][-i - 1] = 'O' }
          player = Player.new(2)
          expect(game.player_won?(player)).to eql(true)
        end

        it "return false if player 1 didn't mark right to left diagonal" do
          game = TicTacToe.new
          (0..game.board.size - 1).map { |i| game.board[i][-i - 1] = 'O' }
          player = Player.new(1)
          expect(game.player_won?(player)).to eql(false)
        end

        it "return false if player 2 didn't mark right to left diagonal" do
          game = TicTacToe.new
          (0..game.board.size - 1).map { |i| game.board[i][-i - 1] = 'X' }
          player = Player.new(2)
          expect(game.player_won?(player)).to eql(false)
        end
      end
    end
  end
end

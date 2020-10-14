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
# frozen_string_literal: true

class Test
  attr_reader :state, :raw, :children, :valid_moves, :board

  def initialize(attr = {})
    @board = VirtualBoard.new
    @logic = CpuLogic.new
    @test = @board.set_state(attr[:board])
    # @valid_moves = []
  end

  def make_move(move)
    value = @logic.make_move(move, @test)
    @board.update_state(value)
  end

  def get_move
    move = @valid_moves.sample
    move
  end

  # def convert
  #   state = []
  #   board = @board.games
  #   board.each do |game|
  #     init = []
  #     game.cells.each do |cell|
  #       init << cell.mark
  #     end
  #     state << [game.place, game.status, 'no', init]
  #   end
  #   state
  # end

  def available_moves
    moves =  @test.find {|s| s[1] == "open" }
      # @valid_moves.empty? ? moves = @test[0] : moves
      indexes = moves[3].each_with_index.select {|c,i | c == "nothing"}
      @valid_moves = indexes
  end


    WINNING_COMBOS = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6]
    ].freeze

    def check_cross
      WINNING_COMBOS.any? do |x|
       
        x.all? do |y|
  
          @test[y][2] == "cross"
        end
      end
    end
  

    def check_nought
         WINNING_COMBOS.any? do |x|
        x.all? do |y|
          @test[y][2] == "nought"
        end
      end
    end

    def finished?

    end
  

    def check_won?
      
      if @valid_moves.empty? || check_nought || check_cross 
        true
      else
        false
      end
    end
end

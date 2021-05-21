class Test
attr_accessor :state, :raw, :children, :valid_moves, :board
    def initialize(attr = {})
        @board = attr[:board]
        @logic = CpuLogic.new
      
    end
  
def tet
  state = [[1, "open", "no", ["nothing", "nothing", "nothing", "nothing", "nothing", "nothing", "nothing", "nothing", "nothing"]], [2, "closed", "no", ["nothing", "nothing", "nothing", "nothing", "nothing", "nothing", "nothing", "nothing", "nothing"]], [3, "closed", "no", ["nothing", "nothing", "nothing", "nothing", "nothing", "nothing", "nothing", "nothing", "nothing"]], [4, "closed", "no", ["nothing", "nothing", "nothing", "nothing", "nothing", "nothing", "nothing", "nothing", "nothing"]], [5, "closed", "no", ["nothing", "nothing", "nothing", "nothing", "nothing", "nothing", "nothing", "nothing", "nothing"]], [6, "closed", "no", ["nothing", "nothing", "nothing", "nothing", "nothing", "nothing", "nothing", "nothing", "nothing"]], [7, "closed", "no", ["nothing", "nothing", "nothing", "nothing", "nothing", "nothing", "nothing", "nothing", "nothing"]], [8, "closed", "no", ["nothing", "nothing", "nothing", "nothing", "nothing", "nothing", "nothing", "nothing", "nothing"]], [9, "closed", "no", ["nothing", "nothing", "nothing", "nothing", "nothing", "nothing", "nothing", "nothing", "nothing"]]]
  valid_moves = [["nothing", 0], ["nothing", 1], ["nothing", 2], ["nothing", 3], ["nothing", 4], ["nothing", 5], ["nothing", 6], ["nothing", 7], ["nothing", 8]]
  puts "list"
  p state
  p valid_moves
   @logic.make_move(valid_moves, state )
end


def convert
  puts "why"
  puts @board
  state= []
    board = @board.games
    
    board.each do |game|
        init = []
        game.cells.each do |cell|
            init << cell.mark
        end
        state << [game.place , game.status, "no", init]
    end
    state
end





    def valid_move
      puts "ilk"
      state = convert
      puts "kli"
       moves = state.find {|s| s[1] == "open" }
       moves.nil? ? moves = state[0] : moves
       indexes = moves[3].each_with_index.select {|c,i | c == "nothing"}
       indexes
    end

    

    # def expand
    #     move = self.valid_moves.sample
    #     create_child(move)
    #   end

    #   WINNING_COMBOS = [
    #     [0, 1, 2],
    #     [3, 4, 5],
    #     [6, 7, 8],
    #     [0, 3, 6],
    #     [1, 4, 7],
    #     [2, 5, 8],
    #     [0, 4, 8],
    #     [2, 4, 6]
    #   ].freeze

    # def play
    #     playout
    #     check_score
    # end

    # def playout
    #     until check_won?
    #       make_move
    #     end
    # end


    def make_move
      move = self.board.valid_moves.sample
      if !move.nil?
      if move[0] == "nothing"
        index = move[1]
        # @count += 1
        # puts @count
        new_state = self.board.state
        # change the cell value
        test = new_state.find {|s| s[1] == "open" }
         test[3][index] = @cpu ?  "nought" : "cross"
         test[1] = "closed"
         new_state[test[0]-1] = test
         @check = new_state
   
         if game_cross(test[3])
          test[2] = "cross"
         elsif game_nought(test[3])
          test[2] = "nought"
         end
         new_state[index][1] = "open" 
         @cpu = !cpu

         check_won?
         @check = new_state
        else
          puts "this is the end"
        end
      end
      end

    #   def check_cross
    #     if @check.empty?
    #       false
    #     else
    #     WINNING_COMBOS.any? do |x|
    #       x.all? do |y|
    #         @check[y][2] == "cross"
    #       end
    #     end
    #   end
    #   end
      

    #   def game_cross(game)
    #     WINNING_COMBOS.any? do |x|
    #       x.all? do |y|
    #         game[y] == "cross"
    #       end
    #     end
    #   end

    #   def game_nought(game)

        
    #     WINNING_COMBOS.any? do |x|
    #       x.all? do |y|
    #         game[y] == "nought"
    #       end
    #     end
    #   end

    #   def check_nought
    #     if @check.empty?
    #       false
    #     else
    #        WINNING_COMBOS.any? do |x|
    #       x.all? do |y|
    #         @check[y][2] == "nought"
    #       end
    #     end
    #     end
       
      
    #   end
    
    #   def check_score
    #     if check_nought
    #       "nought"
    #     else
    #       "no"
    #     end
    #   end
      
    #   def finished?

    #   end

    #   def check_won?
       
    #    p @board.valid_move
    #    puts @board.valid_moves.count
    #     if check_nought || check_cross || @board.valid_moves.count == 0
    #       true
    #     else
    #       false
    #     end
    #   end

end
class Node
    attr_accessor :raw, :play, :state, :visits, :wins, :parent, :children, :valid_moves, :leaf, :why
    
    def initialize(attr = {})
      @raw = Test.new(board: attr[:raw])
        @parent = attr[:parent]
        @state = attr[:state] ||= 
        @play = attr[:play]

        @wins = 0.0
        @visits = 0
        @children = []
        @valid_moves = @raw.valid_move
        @leaf =  !root? || finished?
       
        
      
    end


    def finished?
      if @valid_moves.any? {|x| x[0] == "nothing" }
        false
      else 
        true
      end
    end

    def uct_value
        win_percentage + 2 * Math.sqrt(Math.log(parent.visits)/@visits)
      end
  
      def win_percentage
        @wins/@visits
      end
  
      def root?
        false
      end
  
      def leaf?
        
      end
  
      def uct_select_child
        children.max_by &:uct_value
      end
  
      
      def expand
        # @raw.valid_move
        move = @valid_moves.sample
        puts "3"
        puts move
        puts @valid_moves
        create_child(move)
      end
  
    #   def valid_move
    #     moves =  self.state.find {|s| s[1] == "open" }
    #     @valid_moves.empty? ? moves = self.state[0] : moves
    #     indexes = moves[3].each_with_index.select {|c,i | c == "nothing"}
    #     @valid_moves = indexes
        
    #  end



      def rollout
        playout = Playout.new(self)
        puts "test545"
        playout.play
      end
  
      def won
        @visits += 1
        @wins += 1
      end
  
      def lost
        @visits += 1
      end
  
      def backpropagate(won)
        puts "hello"
       
        node = self
        node.update_won(won)
        until node.root? do
          puts "not root"
          won == "nought" ? won =  "no" : won = "nought"  # switching players perspective
          puts won
          node = node.parent
          node.update_won(won)
        end
      end
  
      def valid_moves?
        !@valid_moves.empty?
      end
  
      def update_won(won)
        if won == "nought"
          self.won
          won
        else
          self.lost
          won
        end
      end
  
      private
  
      def create_child(move)
        game_state = @raw.dup
        move = move
        puts move
        # explore(move)
        child = Node.new({ raw: game_state.board,   parent: self, play: move })
        # child.play = move
        @children << child
        child
      end

      def explore(move)
        index = move[1]
        new_state = self.state
        # change the cell value
        test = new_state.find {|s| s[1] == "open" }
         test[3][index] = "nought"
         test[1] = "closed"
       new_state[index][1] = "open"
       new_state[test[0]-1] = test 
      #  if game_cross(test[3])
      #     test[2] = "cross"
      #    elsif game_nought(test[3])
      #     test[2] = "nought"
      #    end
         new_state[index][1] = "open" 
       new_state
      end

      def make_move(move)
     
       
        
  
        if !move.nil?
        if move[0] == "nothing"
          index = move[1]
          # @count += 1
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
  
        def check_cross
          if @check.empty?
            false
          else
          WINNING_COMBOS.any? do |x|
            x.all? do |y|
              @check[y][2] == "cross"
            end
          end
        end
        end
        
  
        def game_cross(game)
          WINNING_COMBOS.any? do |x|
            x.all? do |y|
              game[y] == "cross"
            end
          end
        end
  
        def game_nought(game)
  
          
          WINNING_COMBOS.any? do |x|
            x.all? do |y|
              game[y] == "nought"
            end
          end
        end
  
        def check_nought
          if @check.empty?
            false
          else
             WINNING_COMBOS.any? do |x|
            x.all? do |y|
              @check[y][2] == "nought"
            end
          end
          end
         
        
        end
      
        def check_score
          if check_nought
            "nought"
          else
            "no"
          end
        end
        
  
        def check_won?
          if check_nought || check_cross || @board.valid_moves.count == 0
            true
          else
            false
          end
        end

end
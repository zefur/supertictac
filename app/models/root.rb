class Root < Node
  attr_accessor :raw, :play, :state, :visits, :wins, :parent, :children, :valid_moves  
  def initialize(attr ={})
      super 
      @state = @raw.convert
      # convert
      # @raw.valid_move
    end


# def convert
    
#   board = @raw.games
#   board.each do |game|
#       init = []
#       game.cells.each do |cell|
#           init << cell.mark
#       end
#        @state << [game.place , game.status, "no", init]
#   end
#   @state
# end


    def root?
      true
    end

    def best_child
      children.max_by &:win_percentage
    end

    def best_move
      best_child.play
    end

    def explore_tree
      puts "start"
      selected_node = select
      playout_node =  if selected_node.leaf
        puts "1"
                        selected_node
                      else
                        puts "2"
                        puts selected_node
                        selected_node.expand

                      end
                      puts playout_node
      won = playout_node.rollout
      
      playout_node.backpropagate(won)
    end

    def update_won(won)
      # logic reversed as the node accumulates its children and has no move
      # of its own
      if won
        self.lost
      else
        self.won
      end
    end

    private
    def select
      node = self
      puts node
      puts "eeee"
      until valid_moves? || leaf? do
        node = uct_select_child
      end
      node
    end
  end
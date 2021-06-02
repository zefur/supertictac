# frozen_string_literal: true

class Node
  attr_reader :raw, :play, :state, :visits, :wins, :parent, :children, :valid_moves, :leaf, :why

  def initialize(attr = {})
    @parent = attr[:parent]
    @state = attr[:state]
    @play = attr[:play]

    @wins = 0.0
    @visits = 0
    @children = []
    @valid_moves = [] 
    @leaf =  valid_moves.empty?
  end

  # def finished?
  #   if @valid_moves.any? { |x| x[0] == 'nothing' }
  #     false
  #   else
  #     true
  #   end
  # end

  def uct_value
    win_percentage + 2 * Math.sqrt(Math.log(parent.visits) / @visits)
  end

  def win_percentage
    @wins / @visits
  end

  def root?
    false
  end

  def leaf? 
  @leaf
  end

  def uct_select_child
    children.max_by(&:uct_value)
  end

  def expand
    p @valid_moves
    move = @valid_moves.pop
    create_child(move)
  end

  #   def valid_move
  #     moves =  self.state.find {|s| s[1] == "open" }
  #     @valid_moves.empty? ? moves = self.state[0] : moves
  #     indexes = moves[3].each_with_index.select {|c,i | c == "nothing"}
  #     @valid_moves = indexes

  #  end

  def rollout
    playout = Playout.new(@state)
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
    puts 'hello'
    node = self
    node.update_won(won)
    until node.root?
      puts 'not root'
      
      won = !won  # switching players perspective
      puts won
      node = node.parent
      node.update_won(won)
    end
  end

  def valid_moves?
    !@valid_moves.empty?
  end

  def update_won(won)
    if won
      self.won
      puts "node won"
    else
      self.lost
      puts "node lost"
    end
  end

  private

  def create_child(move)
    game_state = @state.deep_dup
    game_state.make_move(move)
    puts game_state
    puts self
    child = Node.new({ state: game_state , parent: self, play: move })
    # child.valid_moves = game_state.available_moves
    @children << child
    child
  end

 
end

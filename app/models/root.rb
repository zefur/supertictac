# frozen_string_literal: true

class Root < Node
  attr_reader :raw, :play, :state, :visits, :wins, :parent, :children, :valid_moves

  def initialize(attr = {})
    super

    @state = attr[:board]
    @valid_moves = @state.available_moves
    @leaf = false
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
    children.max_by(&:win_percentage)
  end

  def best_move
    best_child.play
  end

  def explore_tree
    # binding.pry
    reset = @state.state
    selected_node = select
    playout_node =  if selected_node.leaf?
                      selected_node
                    else
                      selected_node.expand

                    end
    puts playout_node
    won = playout_node.rollout
    @state.state = reset
    playout_node.backpropagate(won)
  end

  def update_won(won)
    # logic reversed as the node accumulates its children and has no move
    # of its own
    if won
      lost
      puts 'root lost'
    else
      self.won
      puts 'root won'
    end
  end

  private

  def select
    node = self
    puts node
    puts 'eeee'
    node = uct_select_child until valid_moves? || leaf?
    puts node
    puts node.valid_moves?
    puts node.leaf?
    puts node.children.count
    node
  end
end

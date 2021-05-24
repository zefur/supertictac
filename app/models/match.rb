# frozen_string_literal: true

class Match < ApplicationRecord
  def intitialize(board)
    @parent
    @board_state = board.games.to_a.map do |game|
      me = []
      me << game.serializable_hash(only: %i[id status])
      me << game.cells.to_a.map do |cell|
        cell.serializable_hash(only: %i[id mark place])
      end
      me
    end
    @move

    @wins
    @visits
    @children = []
    @untried_moves
  end

  def uct_value
    win_percentage + UCT_BIAS_FACTOR * Math.sqrt(Math.log(parent.visits) / @visits)
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
    move = @untried_moves.sample
    create_child(move)
  end

  def rollout; end

  def create_child; end
end

# board.games.to_a.map(&:cells).to_a(&:serlialize_hash)

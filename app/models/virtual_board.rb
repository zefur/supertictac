# frozen_string_literal: true

class VirtualBoard
  attr_reader :state, :valid_moves

  def initialize
    
    @valid_moves
  end

  def set_state(board)
    state =[]
    board.games.each do |game|
      init = []

      game.cells.each do |cell|
        init << cell.mark
      end
      state << [game.place, game.status, 'no', init]
    end
    state
  end

  def update_state(new_state)
    state = new_state
    state
  end

 
end

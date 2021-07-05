class Playout
  attr_accessor :board, :cpu, :check, :count

  def initialize(state)
    @state = state.dup
    @cpu = true
    @count = 0
    @check = []
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

  def play
    playout
    @state.check_nought
  end

  def playout
    @state.make_move @state.get_move until @state.check_won?
  end
end

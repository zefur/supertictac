# frozen_string_literal: true

class CpuLogic
  def initialize
    @cpu = true
  end

  def make_move(move, state)
    if move[0] == 'nothing'
      index = move[1]
      new_state = state

      test = new_state.find { |s| s[1] == 'open' }

      test[3][index] = @cpu ? 'nought' : 'cross'
      test[1] = 'closed'
      new_state[test[0] - 1] = test

      if game_cross(test[3])
        test[2] = 'cross'
      elsif game_nought(test[3])
        test[2] = 'nought'
      end
      new_state[index][1] = 'open'
      @cpu = !@cpu

      new_state
      p new_state
    else
      puts 'this is the end'
    end
  end

  def game_cross(game)
    WINNING_COMBOS.any? do |x|
      x.all? do |y|
        game[y] == 'cross'
      end
    end
  end

  def game_nought(game)
    WINNING_COMBOS.any? do |x|
      x.all? do |y|
        game[y] == 'nought'
      end
    end
  end

  def finished?; end
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

# frozen_string_literal: true

class Game < ApplicationRecord
  belongs_to :board
  has_many :cells, dependent: :destroy

  player1_turn = true

  def swap_turns 
    player1_turn = !player1_turn
  end

  def check_win
    WINNING_COMBOS.any? do |combos|
      combos.all? do |y|
        cells[y].cross?
      end
    end
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
end

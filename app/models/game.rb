# frozen_string_literal: true

class Game < ApplicationRecord
  include CableReady::Broadcaster
  enum status: { closed: 0, open: 1 }
  enum game_won: { playing: 0, cross: 1, nought: 2, draw: 3 }
  belongs_to :board
  has_many :cells, dependent: :destroy

  

  def check_cross
    WINNING_COMBOS.any? do |combos|
      combos.all? do |y|
        cells[y].cross?
      end
    end

  end
  def check_nought
    WINNING_COMBOS.any? do |combos|
      combos.all? do |y|
        cells[y].nought?
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

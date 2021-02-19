# frozen_string_literal: true

class Board < ApplicationRecord
  has_many :games, dependent: :destroy
  belongs_to :game_room


  def check_cross
    WINNING_COMBOS.any? do |x|
      x.all? do |y|
        games[y].cross?
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

def reset
  self.games.each do |x|
    x.game_won = false
    x.cells.each {|y| y.nothing!}
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

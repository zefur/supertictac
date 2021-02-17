# frozen_string_literal: true

class Board < ApplicationRecord
  has_many :games, dependent: :destroy
  belongs_to :game_room
# this only connects some of the time and then it still doesnt broadcast
  def self.start(player1, player2)
    # Randomly choses who gets to be noughts or crosses
    cross, nought = [player1, player2].shuffle

    # Broadcast back to the players subscribed to the channel that the game has started
    ActionCable.server.broadcast "player_#{cross}", { action: 'game_start', msg: 'Cross' }
    ActionCable.server.broadcast "player_#{nought}", { action: 'game_start', msg: 'Nought' }

    # Store the details of each opponent
    REDIS.set("opponent_for:#{cross.user_name}", nought)
    REDIS.set("opponent_for:#{nought.user_name}", cross)
  end

  def check_win
    WINNING_COMBOS.any? do |x|
      x.all? do |y|
        games[y].cross?
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

# frozen_string_literal: true

class GameRoom < ApplicationRecord
  include CableReady::Broadcaster

  extend FriendlyId

  belongs_to :user
  friendly_id :room_name, use: :slugged

  has_one :board, dependent: :destroy
  serialize :players, Array
  serialize :viewers, Array
  enum player_turn: { player1: 0, player2: 1 }

  def join(user)
    unless players.any?(user) || viewers.any?(user)
      if players.count < 2
        players << user
      else
        viewers << user
      end
      save
    end
  end

  def leave(user)
    players.delete(user) || viewers.delete(user)
    if self.players.count == 0
      self.destroy
    end
    save
  end

  def restart
    board.started = false
    board.save
    board.reset
    player1!
  end

  def start(_board)
    board.started = true
    board.save
    
  end
end

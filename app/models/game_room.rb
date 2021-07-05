# frozen_string_literal: true

class GameRoom < ApplicationRecord
  include CableReady::Broadcaster
  validates_uniqueness_of :room_name, on: :create, message: 'must be unique'
  extend FriendlyId

  belongs_to :user
  friendly_id :room_name, use: :slugged
  has_many :messages, dependent: :delete_all
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
    cable_ready[GameRoomChannel].insert_adjacent_html(
      selector: '#chat-area',
      position: "beforeend",
      html: "<div>hello</div>"
    ).broadcast_to(self)
  end

  def leave(user)
    players.delete(user) || viewers.delete(user)
    cable_ready[GameRoomChannel].insert_adjacent_html(
      selector: '#chat-area',
      position: "beforeend",
      html: "<div>hello</dive"
    ).broadcast_to(self)
    destroy if players.count == 0 
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

  def total_users
    self.players.count + self.viewers.count
  end

end

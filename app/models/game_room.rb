# frozen_string_literal: true

class GameRoom < ApplicationRecord
  include CableReady::Broadcaster
  # this doesnt work, trying to abstract it out from the reflex controller 
  # delegate :render, to: :ApplicationController
  # after_update do
  #   cable_ready[GameRoomChannel].morph(
  #     selector: "#why",
  #     children_only: true,
  #     html: render(BoardComponent.new({board: self.board}))
  #   ).broadcast_to(self)
  # end
  has_one :board, dependent: :destroy
  has_many :game_room_users, dependent: :destroy
  has_many :users, through: :game_room_users
  serialize :players, Array
  serialize :viewers, Array
  # validates_length_of :users, maximum: 2

  def join(user)
    unless self.players.any?(user) || self.viewers.any?(user)
    if self.players.count < 2
      self.players << user
      else
       self.viewers << user
      end
      self.save  
    end
  end

  def leave(user)
    self.players.delete(user) || self.viewers.delete(user)
    self.save
  end

  def restart
    self.board.started = false
    self.board.save
    self.board.reset
    
  end

  def start
    self.board.started = true
    self.board.save
  end
  
  def make_turn
    whose_turn = self.players[0] 
  end

  @@current_player = self.players[0]
end
# frozen_string_literal: true

class GameRoom < ApplicationRecord
  include CableReady::Broadcaster
  
  extend FriendlyId
  
  belongs_to :user
  friendly_id :room_name, use: :slugged
  
  has_one :board, dependent: :destroy
  serialize :players, Array
  serialize :viewers, Array
  enum player_turn: {player1: 0, player2: 1}


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
    # if self.players.count == 0
    #   self.destroy
    # end
    self.save
  end

  def restart
    self.board.started = false
    self.board.save
    self.board.reset
    self.player1!
  end

  def start
    self.board.started = true
    self.board.save
  end
  
  

  
end
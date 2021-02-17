# frozen_string_literal: true

class GameRoom < ApplicationRecord
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
    self.board.game_finishd = false
    self.board.reset
  end
end

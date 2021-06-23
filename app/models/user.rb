# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :game_rooms, dependent: :destroy
  has_many :messages
  def won
    self.wins += 1
    self.save
  end

  def lost
    self.losses += 1
    self.save
  end
end

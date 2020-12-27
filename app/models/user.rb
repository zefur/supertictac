# frozen_string_literal: true

class User < ApplicationRecord
  has_many :game_room_users
  has_many :game_rooms, through: :game_room_users
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end

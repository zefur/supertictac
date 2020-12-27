class GameRoom < ApplicationRecord
    has_many :boards
    has_many :game_room_users
    has_many :users, through: :game_room_users
    
        def self.create(current_or_guest_user)
          if REDIS.get("game_rooms").blank?
            REDIS.set("game_rooms", current_or_guest_user)
          else
          # Get the uuid of the player waiting
            opponent = REDIS.get("game_rooms")
      
            Board.start(current_or_guest_user, opponent)
            # Clear the waiting key as no one new is waiting
            REDIS.set("game_rooms", nil)
          end
        end
      
end

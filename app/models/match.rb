class Match < ApplicationRecord

    # this is from the cookiehq tictac toe tutorial, I couldnt get it to work it makes sense if I land 
    def self.create(current_or_guest_user)
        if REDIS.get("matches").blank?
          REDIS.set("matches", current_or_guest_user)
        
        else
        # Get the uuid of the player waiting

          opponent = REDIS.get("matches")
    
          Board.start(current_or_guest_user, opponent)
          # Clear the waiting key as no one new is waiting
          REDIS.set("matches", nil)
        end
      end

    
end
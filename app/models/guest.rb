# frozen_string_literal: true

class Guest < User

    def clean_up
        self.game_rooms.destroy_all
    end
end

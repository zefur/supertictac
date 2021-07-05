# frozen_string_literal: true

class Guest < User
  def clean_up
    game_rooms.destroy_all
  end
end

# frozen_string_literal: true

class ComputerMoveJob < ApplicationJob
  include CableReady::Broadcaster
  queue_as :default

  def perform
    @game_room.board.make_move_computer
  end
end

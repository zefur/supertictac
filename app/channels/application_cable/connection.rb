# frozen_string_literal: true

module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_or_guest_user
    identified_by :session_id

    def connect
      self.current_or_guest_user = env['warden'].user
      self.session_id = request.session.id
      reject_unauthorized_connection unless current_or_guest_user || session_id
    end
  end
end

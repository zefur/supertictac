# frozen_string_literal: true

class Cell < ApplicationRecord
  include CableReady::Broadcaster
  enum mark: { nothing: 0, cross: 1, nought: 2 }
  belongs_to :game 
end

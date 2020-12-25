# frozen_string_literal: true

class Board < ApplicationRecord
  has_many :games, dependent: :destroy
end

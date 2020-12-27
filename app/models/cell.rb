# frozen_string_literal: true

class Cell < ApplicationRecord
  enum mark: { nothing: 0, cross: 1, nought: 2 }
  belongs_to :game

  def choice
    if nothing?
      cross!
    elsif cross?
      nought!
    else
      nothing!
    end
  end
end

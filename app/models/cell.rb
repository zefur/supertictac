# frozen_string_literal: true

class Cell < ApplicationRecord
  enum mark: { nothing: 0, cross: 1, nought: 2 }
  belongs_to :game

  def choice
    if self.nothing?
      self.cross!
    elsif self.cross?
      self.nought!
    else
      self.nothing!
    end
  end
end

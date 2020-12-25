# frozen_string_literal: true

class PagesController < ApplicationController
  before_action :set_game
  def home
    @cells = Cell.all
    @games = Game.all
    @test ||= '0'
  end

  private

  def set_game
    @board = Board.first
  end

  def check_game; end

  def check_board; end
end

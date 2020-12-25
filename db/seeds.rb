# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
1.times do
  Board.create
  Board.all.each do |board|
    9.times do
      Game.create(board_id: board.id)
    end
  end
end
Game.all.each do |game|
  9.times do
    Cell.create(game_id: game.id)
  end
end

# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
1.times do
  GameRoom.create
  GameRoom.all.each do |game_room|
    Board.create(game_room_id: game_room.id)
  end

  Board.all.each do |board|
    9.times do
      Game.create!(board_id: board.id)
    end
  end
end
Game.all.each do |game|
  Cell.create(game_id: game.id, place: 1)
  Cell.create(game_id: game.id, place: 2)
  Cell.create(game_id: game.id, place: 3)
  Cell.create(game_id: game.id, place: 4)
  Cell.create(game_id: game.id, place: 5)
  Cell.create(game_id: game.id, place: 6)
  Cell.create(game_id: game.id, place: 7)
  Cell.create(game_id: game.id, place: 8)
  Cell.create(game_id: game.id, place: 9)
end

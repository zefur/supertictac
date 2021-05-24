# frozen_string_literal: true

class Board < ApplicationRecord
  has_many :games, dependent: :destroy
  belongs_to :game_room
  attr_accessor :move_list

  has_closure_tree

  def check_cross
    WINNING_COMBOS.any? do |x|
      x.all? do |y|
        games[y].cross?
      end
    end
  end

  def check_nought
    WINNING_COMBOS.any? do |combos|
      combos.all? do |y|
        games[y].nought?
      end
    end
  end

  def reset
    games.each do |x|
      x.game_won = false
      x.closed!
      x.cells.each(&:nothing!)
      x.cells.each do |cell|
        cell.free = true
        cell.save
      end
    end
  end

  WINNING_COMBOS = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8],
    [0, 4, 8],
    [2, 4, 6]
  ].freeze
  @move_list = []
  def make_move_computer
    game = games.where(status: 'open')

    empty_cells = game[0].cells.where(free: true)

    empty_cells.sample
  end

  def check_won?
    # cells = self.games.each {|game| game.cells.where(free: true)}
    if check_cross || check_nought || valid_moves.empty?
      puts 'GAME OVER !!!!!!!!!'
      puts 'James' if valid_moves.empty?
      true
    else
      false
    end
  end

  def monte
    puts 'test'
    game = games.where(status: 'open')
    game.count.zero? ? game = games : game
    empty_cells = game.sample.cells.where(free: true)
    cell = empty_cells.sample
    puts empty_cells
    if game_room.player_turn == 'player1'
      cell.cross!
      cell.game.board.game_room.player2!
    else
      cell.nought!
      cell.game.board.game_room.player1!
    end
    cell.toggle!(:free)
    # turn = ["player1", "player2"].cycle
    # self.game_room.player_turn = turn.next
    # self.game_room.save
    puts cell

    cell
  end

  def valid_moves
    game = games.where(status: 'open')
    game.count.zero? ? game = games : game
    empty_cells = game.sample.cells.where(free: true)
    puts 'no valid moves' if empty_cells.count.zero?
    empty_cells
  end

  def undo(cell)
    cell.nothing?
    cell.toggle(:free)
  end

  def make_cross_move(cell)
    cell.cross!
    cell.toggle!(:free)
    activate_next(cell)
    deactivate_last(cell)
  end

  def make_nought_move(cell)
    cell.nought!
    cell.toggle!(:free)
    activate_next(cell)
    deactivate_last(cell)
  end

  def activate_next(cell)
    index = cell.place - 1
    if games.where(status: 'open').count.zero?
      games[index].open!
    elsif games[index] != Game.find(cell.game_id)
      games[index].open!
    end
  end

  def deactivate_last(cell)
    game = Game.find(cell.game_id)
    game.closed! if game != games[cell.place - 1]
  end

  def explore(cell)
    game_room.player_turn == 'player1' ? cell.cross! : cell.nought!
    cell.toggle!(:free)
    turn = %w[player1 player2].cycle
    game_room.player_turn = turn.next
    game_room.save
    computer_predict(cell)
  end

  def cpu_activate_next(cell)
    index = cell.place - 1
    puts index
    if games.where(status: 'open').count.zero?
      games[index].open!

    elsif games[index] != Game.find(cell.game_id)
      games[index].open!
    end
  end

  def cpu_deactivate_last(cell)
    game = Game.find(cell.game_id)
    game.closed! if game != games[cell.place - 1]
  end

  def computer_predict(cell)
    cpu_activate_next(cell)
    cpu_deactivate_last(cell)
    puts 'jabber jabber'

    games[cell.place - 1]
  end

  # methods for the MCTS algorithm

  #   def legal_plays(board)
  #     plays = board.games.find_by(status: "open").cells.where(free: true)
  #     puts "11111111"
  #     p plays.class
  #     p plays
  #     plays
  #   end

  #   def next_state(state, move)
  # state.game.where(status: "open")
  # computer_predict(move)
  #   end

  #   def winner(state)
  #     if check_cross
  #       -1
  #     elsif check_nought
  #       1
  #     else
  #       0
  #     end

  #   end
end

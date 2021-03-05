# frozen_string_literal: true

class Board < ApplicationRecord
  has_many :games, dependent: :destroy
  belongs_to :game_room
  attr_accessor :move_list
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
     game = self
     comp_move = self.game_room.players[1].run_search(game)
     make_nought_move(comp_move)
    
  end

  def undo(cell)
      cell.nothing?
      cell.toggle(:free)
  end


  def make_cross_move(cell)
    cell.cross!
    cell.toggle(:free)
    activate_next(cell)
    deactivate_last(cell)
  end

  def make_nought_move(cell)
    cell.nought!
    cell.toggle(:free)
    activate_next(cell)
    deactivate_last(cell)
  end

  def activate_next(cell)
    index = cell.place - 1
    self.games[index].open!
    
  end

  def deactivate_last(cell)
    game = Game.find(cell.game_id)
    game.closed!
  end

  def cpu_activate_next(cell)
    index = cell.place - 1
    self.games[index].status = "open"
  end

  def cpu_deactivate_last(cell)
    game = Game.find(cell.game_id)
    game.status = "closed"
  end

  def computer_predict(cell)
    self.cpu_activate_next(cell)
    self.cpu_deactivate_last(cell)
    game = self.games[cell.place - 1]
    game
  end


  # methods for the MCTS algorithm

  def legal_plays(board)
    plays = board.games.find_by(status: "open").cells.where(free: true)
    puts "11111111"
    p plays.class
    p plays
    plays
  end

  def next_state(state, move)
state.game.where(status: "open")
computer_predict(move)
  end

  def winner(state)
    if check_cross
      -1
    elsif check_nought
      1
    else
      0
    end

  end
end

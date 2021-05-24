# frozen_string_literal: true

class Computer
  attr_accessor :user_name, :board, :depth, :state, :check

  def initialize(attr = { UCB1ExploreParam: 2 })
    @board = Test.new(board: attr[:board])
    @user_name = 'H.A.L'
    @depth = 20
    @UCB1ExploreParam = attr[:UCB1ExploreParam]
    @state = []
    @finished = false
    # convert
    @check
  end

  def remove
    delete
  end

  def convert
    @board.games.each do |game|
      init = []
      game.cells.each do |cell|
        init << cell.mark
      end
      @state << [game.place, game.status, 'no', init]
    end
    @state
  end

  def valid_move
    # moves =  self.state.find {|s| s[1] == "open" }
    # moves.nil? ? moves = self.state[0] : moves
    # indexes = moves[3].each_with_index.select {|c,i | c == "nothing"}
    # @valid_moves = indexes
    @board.valid_move
  end

  def make_move
    board.valid_move
    move = board.valid_moves.sample

    unless move.nil?
      if move[0] == 'nothing'
        index = move[1]
        @count += 1
        new_state = board.state
        # change the cell value
        test = new_state.find { |s| s[1] == 'open' }
        test[3][index] = @cpu ? 'nought' : 'cross'
        test[1] = 'closed'
        new_state[test[0] - 1] = test
        @check = new_state

        if game_cross(test[3])
          test[2] = 'cross'
        elsif game_nought(test[3])
          test[2] = 'nought'
        end
        new_state[index][1] = 'open'
        @cpu = !cpu

        check_won?
        @check = new_state
      else
        puts 'this is the end'
      end
    end
  end

  def check_cross
    if @check.empty?
      false
    else
      WINNING_COMBOS.any? do |x|
        x.all? do |y|
          @check[y][2] == 'cross'
        end
      end
    end
  end

  def game_cross(game)
    WINNING_COMBOS.any? do |x|
      x.all? do |y|
        game[y] == 'cross'
      end
    end
  end

  def game_nought(game)
    WINNING_COMBOS.any? do |x|
      x.all? do |y|
        game[y] == 'nought'
      end
    end
  end

  def check_nought
    if @check.empty?
      false
    else
      WINNING_COMBOS.any? do |x|
        x.all? do |y|
          @check[y][2] == 'nought'
        end
      end
    end
  end

  def check_score
    if check_nought
      true
    else
      false
    end
  end

  def check_won?
    if check_nought || check_cross || @board.valid_moves.count.zero?
      true
    else
      false
    end
  end
end

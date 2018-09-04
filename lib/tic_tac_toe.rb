class TicTacToe
  def initialize(board = nil)
    @board = board || Array.new(9, " ")
  end
  # Define your WIN_COMBINATIONS constant
  WIN_COMBINATIONS = [
    [0,1,2],  # Top row
    [3,4,5],  # Middle row
    [6,7,8],  # Bottom row
    [2,4,6],  # Diagonal 1
    [0,4,8],  # diagonal 2
    [0,3,6],  # left
    [1,4,7],  # Middle
    [2,5,8]  # right
  ]

  def display_board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end

  def input_to_index(user_input)
    user_input.to_i - 1
  end

  def move(index, current_player = "X")
    @board[index] = current_player
  end

  def position_taken?(board, location)
    board[location] != " " && board[location] != ""
  end

  def valid_move?(board, index)
    index.between?(0,8) && !position_taken?(board, index)
  end

  def turn(board)
    puts "Please enter 1-9:"
    input = gets.strip
    index = input_to_index(input)
    if valid_move?(board, index)
      move(board, index, current_player(board))
      display_board(board)
    else
      turn(board)
    end
  end

  def turn_count(board)
    board.count{|cell| cell == "X" || cell == "O"}
  end

  def current_player(board)
    turn_count(board).even? ? "X" : "O"
  end

  def won?(board)
     if board.all? {|index| index == " "  }
       false
     else
       WIN_COMBINATIONS.each do |win_combination|

         if win_combination.all? {|cell| board[cell] == "X"} or win_combination.all? {|cell| board[cell] == "O"}
           return win_combination
         end

        end
        return false
     end
  end
  #full? retur true if board contains only X or O
  def full?(board)
    board.all? {|position| position == "X" or position == "O"}
  end

  def  draw?(board)
    if won?(board) == false and full?(board)
      return true
    else
      return false
    end
  end
  #over? return true if the game is draw or if is won
  def over?(board)
     if draw?(board) == true or won?(board) != false
       return true
     end
  end

  def winner(board)
    if won?(board) != false
      board[won?(board)[0]]
    end
  end

  #play
  def play(board)
    #input = gets
    until over?(board) == true
      turn(board)
    end

    if winner(board) == "X" or winner(board) == "O"
      puts "Congratulations #{winner(board)}!"
    else
      puts "Cat's Game!"
    end
  end

    def current_player
      turn_count % 2 == 0 ? "X" : "O"
    end

    def turn_count
      @board.count{|token| token == "X" || token == "O"}
    end

  
end

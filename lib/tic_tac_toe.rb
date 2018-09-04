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

  def position_taken?(location)
    @board[location] != " " && @board[location] != ""
  end

  def valid_move?(index)
    index.between?(0,8) && !position_taken?(index)
  end

  def turn
    puts "Please enter 1-9:"
    input = gets.strip
    index = input_to_index(input)
    if valid_move?(index)
      move(index, current_player)
      display_board
    else
      turn
    end
  end

  def turn_count
    @board.count{|cell| cell == "X" || cell == "O"}
  end

  def current_player
    turn_count.even? ? "X" : "O"
  end

  def won?
     if @board.all? {|index| index == " "  }
       false
     else
       WIN_COMBINATIONS.each do |win_combination|

         if win_combination.all? {|cell| @board[cell] == "X"} or win_combination.all? {|cell| @board[cell] == "O"}
           return win_combination
         end

        end
        return false
     end
  end
  #full? retur true if board contains only X or O
  def full?
    @board.all? {|position| position == "X" or position == "O"}
  end

  def  draw?
    if won? == false and full?
      return true
    else
      return false
    end
  end
  #over? return true if the game is draw or if is won
  def over?
     if draw? == true or won? != false
       return true
     end
  end

  def winner
    if won? != false
      @board[won?[0]]
    end
  end

  #play
  def play
    #input = gets
    until over? == true
      turn
    end

    if winner == "X" or winner == "O"
      puts "Congratulations #{winner}!"
    else
      puts "Cat's Game!/"
    end
  end

end

# Tic Tac Toe Problem

board = []

def prompt(message)
  puts ">>>>>> #{message}"
end

def display_borard(board)
  board.each do |row|
    row.each { |e| print e }
    print "\n"
  end
end

def board_full?(board)
  !board[0].include?(0) &&
    !board[1].include?(0) &&
    !board[2].include?(0)
end

def get_user_input(coordinate)
  loop do
    prompt "Please input #{coordinate} of square (1 or 2 or 3):"
    input = gets.chomp.to_i

    if [1, 2, 3].include?(input)
      return input
    else
      prompt "Oops... Something wrong. Please input 1 or 2 or 3"
    end
  end
end

def user_square(board)
  loop do
    user_square_row = get_user_input('row')
    user_square_col = get_user_input('col')
    if board[user_square_row - 1][user_square_col - 1].zero
      board[user_square_row - 1][user_square_col - 1] = 1
      break
    else
      prompt "Unluck! Take square, please input another square again!"
    end
  end
end

def computer_square(board)
  loop do
    row = [0, 1, 2].sample
    col = [0, 1, 2].sample
    if board[row][col].zero?
      board[row][col] = 2
      break
    end
  end
end

def win?(board, n)
  board.include?([n, n, n]) ||
    (board[0][0] == n && board[1][0] == n && board[2][0] == n) ||
    (board[0][1] == n && board[1][1] == n && board[2][1] == n) ||
    (board[0][2] == n && board[1][0] == n && board[2][2] == n) ||
    (board[0][0] == n && board[1][1] == n && board[2][2] == n) ||
    (board[0][2] == n && board[1][1] == n && board[2][0] == n)
end

def reset_board(board)
  board.clear
  3.times { board << [0, 0, 0] }
end

reset_board(board)

loop do
  display_borard(board)

  prompt "Please input the square place."
  prompt "Example: square row is 1, col is 2"

  user_square(board)

  computer_square(board)

  if win?(board, 1)
    prompt "You are winner!!!!"
    prompt "Another round?"
    answer = gets.chomp
    break unless answer.downcase.start_with?('y')
    reset_board(board)
  elsif win?(board, 2)
    prompt "Computer is winner!"
    prompt "Another round?"
    answer = gets.chomp
    break unless answer.downcase.start_with?('y')
    reset_board(board)
  elsif board_full?(board)
    prompt "tie~~~~"
    prompt "Another round?"
    answer = gets.chomp
    break unless answer.downcase.start_with?('y')
    reset_board(board)
  end
end

prompt "Thank you for Tic Tac Toe."
prompt "Goood bye!"

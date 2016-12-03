# tic toc toe

require 'pry'
require 'io/console'

INITIAL_MARKER = ' '.freeze
PLAYER_MARKER = 'X'.freeze
COMPUTER_MARKER = 'O'.freeze
WINNING_LINE = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] + # rows
               [[1, 4, 7], [2, 5, 8], [3, 6, 9]] + # cols
               [[1, 5, 9], [3, 5, 7]]              # diagonals

def prompt(message)
  puts ">>>>>> #{message}"
end

def continue_game
  prompt "Press any key to continue"
  STDIN.getch
end

# rubocop:disable Metrics/MethodLength, Metrics/AbcSize
def display_board(brd, p_score = 0, c_score = 0)
  system 'clear'
  prompt "You're a #{PLAYER_MARKER}. Computer is #{COMPUTER_MARKER}"
  prompt "Player score is #{p_score}. Computer score is #{c_score}."
  prompt ""
  prompt "     |     |"
  prompt "  #{brd[1]}  |  #{brd[2]}  |  #{brd[3]}"
  prompt "     |     |"
  prompt "-----+-----+-----"
  prompt "     |     |"
  prompt "  #{brd[4]}  |  #{brd[5]}  |  #{brd[6]}"
  prompt "     |     |"
  prompt "-----+-----+-----"
  prompt "     |     |"
  prompt "  #{brd[7]}  |  #{brd[8]}  |  #{brd[9]}"
  prompt "     |     |"
  prompt ""
end
# rubocop:enable Metrics/MethodLength, Metrics/AbcSize

def intalize_board
  new_board = {}
  (1..9).each { |num| new_board[num] = INITIAL_MARKER }
  new_board
end

def empty_squares(brd)
  brd.keys.select { |num| brd[num] == INITIAL_MARKER }
end

def find_at_risk_square(line, board, marker)
  if board.values_at(*line).count(marker) == 2
    board.select { |k, v| line.include?(k) && v == INITIAL_MARKER }.keys.first
  end
end

def player_places_piece!(brd)
  square = ''
  loop do
    prompt "Choose a square (#{joinor(empty_squares(brd))}):"
    square = gets.chomp.to_i
    break if empty_squares(brd).include?(square)
    prompt "Sorry, that's not a valid choice."
  end

  brd[square] = PLAYER_MARKER
end

def computer_places_piece!(brd)
  square = nil

  # defense first
  WINNING_LINE.each do |line|
    square = find_at_risk_square(line, brd, PLAYER_MARKER)
    break if square
  end

  # offense
  if !square
    WINNING_LINE.each do |line|
      square = find_at_risk_square(line, brd, COMPUTER_MARKER)
      break if square
    end
  end

  # just pick a square
  if !square
    square = empty_squares(brd).sample
  end

  brd[square] = COMPUTER_MARKER
end

def board_full?(brd)
  empty_squares(brd).empty?
end

def someone_win?(brd)
  !!detect_winner(brd)
end

def detect_winner(brd)
  WINNING_LINE.each do |line|
    if brd.values_at(*line).count(PLAYER_MARKER) == 3
      return 'Player'
    elsif brd.values_at(*line).count(COMPUTER_MARKER) == 3
      return 'Computer'
    end
  end
  nil
end

def joinor(arr, delimiter=', ', word='or')
  case arr.size
  when 0 then ''
  when 1 then arr.first
  when 2 then arr.join(" #{word} ")
  else
    arr[-1] = "#{word} #{arr.last}"
    arr.join(delimiter)
  end
end

def round_result(winner)
  if winner
    prompt "This round #{winner} won!"
  else
    prompt "This round is a tie!"
  end
end

def finally_result(p_score, c_score)
  if p_score > c_score
    prompt "Finally Player won!"
  else
    prompt "Finally Computer won!"
  end
end

loop do
  board = intalize_board
  player_score = computer_score = 0

  while player_score < 5 && computer_score < 5
    loop do
      display_board(board, player_score, computer_score)
      player_places_piece!(board)
      break if someone_win?(board) || board_full?(board)

      computer_places_piece!(board)
      display_board(board, player_score, computer_score)
      break if someone_win?(board) || board_full?(board)
    end

    winner = detect_winner(board)
    player_score += 1 if winner == 'Player'
    computer_score += 1 if winner == 'Computer'

    display_board(board, player_score, computer_score)

    round_result(winner)
    continue_game
    board = intalize_board
  end

  finally_result(player_score, computer_score)

  prompt "Play again? (y or n)"
  answer = gets.chomp
  break unless answer.downcase.start_with?('y')
end

prompt "Thanks for palying Tic Tac Toe! Good bye!"

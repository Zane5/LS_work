# tic toc toe

require 'pry'
require 'io/console'

INITIAL_MARKER = ' '.freeze
PLAYER_MARKER = 'X'.freeze
COMPUTER_MARKER = 'O'.freeze
WINNING_LINE = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] + # rows
               [[1, 4, 7], [2, 5, 8], [3, 6, 9]] + # cols
               [[1, 5, 9], [3, 5, 7]]              # diagonals
FIRST_PLAYER = 'choose'.freeze # 'choose', 'computer' or 'player'

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

def find_at_risk_square(line, brd, marker)
  if brd.values_at(*line).count(marker) == 2
    brd.select { |k, v| line.include?(k) && v == INITIAL_MARKER }.keys.first
  end
end

def computer_place_strategy(squ, brd, marker)
  WINNING_LINE.each do |line|
    squ = find_at_risk_square(line, brd, marker)
    break if squ
  end
  squ
end

def computer_places_piece!(brd)
  square = nil

  # offense
  square = computer_place_strategy(square, brd, COMPUTER_MARKER)

  # defense
  square = computer_place_strategy(square, brd, PLAYER_MARKER) unless square

  square = 5 if brd[5] == INITIAL_MARKER && !square
  square = empty_squares(brd).sample unless square

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
      return 'player'
    elsif brd.values_at(*line).count(COMPUTER_MARKER) == 3
      return 'computer'
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

def choose_player(curr_p)
  loop do
    prompt "Please choose who places first, Player(P) or Computer(C)?"
    answer = gets.chomp
    if answer.downcase.start_with?('p')
      curr_p = 'player'
      break
    elsif answer.downcase.start_with?('c')
      curr_p = 'computer'
      break
    end
  end
  curr_p
end

def first_player(curr_p)
  if FIRST_PLAYER == 'choose'
    choose_player(curr_p)
  elsif FIRST_PLAYER == 'player'
    'player'
  else
    'computer'
  end
end

def places_piece!(brd, curr_p)
  if curr_p == 'player'
    player_places_piece!(brd)
  else
    computer_places_piece!(brd)
  end
end

def alternate_player(curr_p)
  if curr_p == 'player'
    'computer'
  else
    'player'
  end
end

loop do
  board = intalize_board
  player_score = computer_score = 0
  current_player = nil

  while player_score < 5 && computer_score < 5
    current_player = first_player(current_player)
    loop do
      display_board(board, player_score, computer_score)
      places_piece!(board, current_player)
      current_player = alternate_player(current_player)
      break if someone_win?(board) || board_full?(board)
    end

    winner = detect_winner(board)
    player_score += 1 if winner == 'player'
    computer_score += 1 if winner == 'computer'

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

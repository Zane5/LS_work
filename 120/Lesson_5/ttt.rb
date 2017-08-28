require 'pry'

class Board
  WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] + # rows
                  [[1, 4, 7], [2, 5, 8], [3, 6, 9]] + # cols
                  [[1, 5, 9], [3, 5, 7]]              # diagonals

  attr_reader :squares

  def initialize
    @squares = {}
    reset_square
  end

  def []=(num, marker)
    @squares[num].marker = marker
  end

  def unmarked_keys
    @squares.keys.select { |key| @squares[key].unmarked? }
  end

  def full?
    unmarked_keys.empty?
  end

  def someone_won?
    !!winning_marker
  end

  # returns winning marker or nil
  def winning_marker
    WINNING_LINES.each do |line|
      squares = @squares.values_at(*line)
      if three_identical_markers?(squares)
        return squares.first.marker
      end
    end
    nil
  end

  def reset_square
    (1..9).each { |key| @squares[key] = Square.new }
  end

  # rubocop: disable Metrics/AbcSize
  def draw
    puts "     |     |"
    puts "  #{@squares[1]}  |  #{@squares[2]}  |  #{@squares[3]}"
    puts "     |     |"
    puts "-----+-----+-----"
    puts "     |     |"
    puts "  #{@squares[4]}  |  #{@squares[5]}  |  #{@squares[6]}"
    puts "     |     |"
    puts "-----+-----+-----"
    puts "     |     |"
    puts "  #{@squares[7]}  |  #{@squares[8]}  |  #{@squares[9]}"
    puts "     |     |"
  end
  # rubocop: enable Metrics/AbcSize

  private

  def three_identical_markers?(squares)
    markers = squares.select(&:marked?).collect(&:marker)
    return false if markers.size != 3
    markers.min == markers.max
  end
end

class Square
  INITIAL_MARKER = " "

  attr_accessor :marker

  def initialize(marker = INITIAL_MARKER)
    @marker = marker
  end

  def to_s
    @marker
  end

  def unmarked?
    marker == INITIAL_MARKER
  end

  def marked?
    marker != INITIAL_MARKER
  end
end

class Player
  attr_reader :marker
  attr_accessor :score, :name

  def initialize(marker)
    @marker = marker
    @score = 0
    @name = ''
  end
end

class TTTGame
  HUMAN_MARKER = "X"
  COMPUTER_MARKER = "O"
  FIRST_TO_MOVE = [HUMAN_MARKER, COMPUTER_MARKER].freeze
  WON_GAME_TIMES = 5
  GOLDEN_LOCATION = 5
  HUMAN_NAMES = %w[Henni\ Padley
                   Savanah\ Burlingame
                   Nikoletta\ Landon
                   Moniqua\ Barrie
                   Selima\ Alvingham].freeze
  COMPUTER_NAMES = %w[Copper
                      Wire
                      Plexi
                      Core
                      Exi].freeze

  attr_reader :board, :human, :computer

  def initialize
    @board = Board.new
    @human = Player.new(HUMAN_MARKER)
    @computer = Player.new(COMPUTER_MARKER)
    @current_marker = FIRST_TO_MOVE.sample
  end

  def play
    display_welcome_message
    set_name
    choose_first_to_move
    choose_your_marker
    clear

    loop do
      game_winner(board)
      display_result
      break unless play_again?
      reset_game
      display_play_again_messae
    end

    display_goodbye_message
  end

  private

  def set_name
    @human.name = HUMAN_NAMES.sample
    @computer.name = COMPUTER_NAMES.sample
    puts "Your name is >>> #{@human.name} <<<"
    puts "AI named >>> #{@computer.name} <<< is waiting for you!"
    puts ''
  end

  def choose_your_marker
    loop do
      puts "Please pick your mark: (A, B, X or Y)"
      input = gets.chomp.upcase
      HUMAN_MARKER.replace input
      break if %w[A B X Y].include? input
      puts "Please just input A, B, X or Y"
    end
  end

  def game_winner(brd)
    loop do
      display_board

      loop do
        current_player_moves(brd)
        break if board.someone_won? || board.full?
        clear_screen_and_display_board if human_turn?
      end
      keep_score
      break if someone_won_game?
      reset_square
    end
  end

  def choose_first_to_move
    loop do
      puts "Please input 1 or 2 choose the first move player: "
      puts ">>> 1.#{human.name} <<< (YOU)"
      puts ">>> 2.#{computer.name} <<< (AI)"
      input = gets.chomp.to_i
      if [1, 2].include?(input)
        @current_marker = FIRST_TO_MOVE[input - 1]
        break
      end
      puts "Hi, make sure input number 1 or 2!"
    end
  end

  def reset_square
    clear
    board.reset_square
  end

  def reset_game
    reset_square
    reset_players_scores
    @current_marker = FIRST_TO_MOVE
  end

  def reset_players_scores
    @human.score = 0
    @computer.score = 0
  end

  def display_score
    puts "You won -=#{human.score}=- tiems."
    puts "Computer won -=#{computer.score}=- times."
    puts ''
    puts "First get #{WON_GAME_TIMES} times is WINNER!"
  end

  def someone_won_game?
    human.score == WON_GAME_TIMES || computer.score == WON_GAME_TIMES
  end

  def keep_score
    case board.winning_marker
    when human.marker
      human.score += 1
    when computer.marker
      computer.score += 1
    end
  end

  def current_player_moves(brd)
    if human_turn?
      human_moves
      @current_marker = COMPUTER_MARKER
    else
      computer_moves(brd)
      @current_marker = HUMAN_MARKER
    end
  end

  def human_turn?
    @current_marker == HUMAN_MARKER
  end

  def display_welcome_message
    puts 'Wecome to Tic Tac Toe!'
    puts ''
  end

  def display_goodbye_message
    puts 'Thans for playing Tic Tac Toe! Goodbye!'
  end

  def clear_screen_and_display_board
    clear
    display_board
  end

  def display_board
    puts "#{human.name} is a #{human.marker}."
    puts "#{computer.name} is a #{computer.marker}."
    puts ''
    display_score
    puts ''
    board.draw
    puts ''
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

  def human_moves
    puts "Choose a square (#{joinor(board.unmarked_keys)}): "
    square = nil
    loop do
      square = gets.chomp.to_i
      break if board.unmarked_keys.include?(square)
      puts "Sorry, that's not a valid choice."
    end

    board[square] = human.marker
  end

  def computer_moves(brd)
    computer_places_piece!(brd)
  end

  def display_winner
    if human.score == 5
      puts "You are the winner!"
    elsif computer.score == 5
      puts "Computer is the winner!"
    end
  end

  def display_result
    clear_screen_and_display_board
    display_winner
  end

  def play_again?
    answer = nil
    loop do
      puts "Would you like to play again? (y/n)"
      answer = gets.chomp.downcase
      break if %w[y n].include? answer
      puts "Sorry, must be y or n"
    end

    answer == 'y'
  end

  def clear
    system 'clear'
  end

  def display_play_again_messae
    puts "Let's play again!"
    puts ''
  end

  def risk_square?(line, marker)
    board.squares.values_at(*line).count(marker) == 2
  end

  def find_at_risk_square(line, board, marker)
    return unless risk_square? line, marker
    board.squares.select do |k, v|
      line.include?(k) && v == 'INITIAL_MARKER'
    end.keys.first
  end

  def computer_places_piece!(brd)
    square = nil

    square = computer_offense(brd, square)
    square = computer_defense(brd, square) unless square
    square = GOLDEN_LOCATION if golden_location_empyt?(brd) && !square
    square = computer_random(brd) unless square

    brd[square] = COMPUTER_MARKER
  end

  def golden_location_empyt?(brd)
    brd.squares[GOLDEN_LOCATION].marker == Square::INITIAL_MARKER
  end

  def computer_defense(brd, square)
    Board::WINNING_LINES.each do |line|
      square = find_at_risk_square(line, brd, HUMAN_MARKER)
      break if square
    end

    square
  end

  def computer_offense(brd, square)
    Board::WINNING_LINES.each do |line|
      square = find_at_risk_square(line, brd, COMPUTER_MARKER)
      break if square
    end

    square
  end

  def computer_random(brd)
    empty_squares(brd).sample
  end

  def empty_squares(brd)
    brd.squares.select { |_, v| v.marker == " " }.keys
  end
end

game = TTTGame.new
game.play

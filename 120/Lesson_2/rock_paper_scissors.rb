# This is rock paper scissors game
# keeping score in class Player
# Add Lizard and Spock
#
RPS = %w[rock paper scissors spock lizard].freeze

# module
module Scores
  def display_add_point(player = human)
    puts "#{player.name} won and just added 1 point"
  end

  def add_point(player = human)
    player.scores += 1
    display_add_point(player)
  end

  def keep_scores
    hum_mv = human.move
    com_mv = computer.move

    if hum_mv > com_mv
      add_point
    elsif hum_mv < com_mv
      add_point(computer)
    else
      puts "All player isn't add any point."
    end
  end

  def clear_scores
    human.scores = 0
    computer.scores = 0
  end

  def display_scores
    puts "#{human.name} get === #{human.scores} points ==="
    puts "#{computer.name} get === #{computer.scores} points ==="
  end
end

# Move
class Move
  def initialize(value)
    @value = value
  end

  def scissors?
    @value == 'scissors'
  end

  def rock?
    @value == 'rock'
  end

  def paper?
    @value == 'paper'
  end

  def lizard?
    @value == 'lizard'
  end

  def spock?
    @value == 'spock'
  end

  def rock_win?(other)
    rock? && (other.scissors? || other.lizard?)
  end

  def paper_win?(other)
    paper? && (other.rock? || other.spock?)
  end

  def scissors_win?(other)
    scissors? && (other.paper? || other.lizard?)
  end

  def lizard_win?(other)
    lizard? && (other.paper? || other.spock?)
  end

  def spock_win?(other)
    spock? && (other.rock? || other.scissors?)
  end

  def >(other)
    rock_win?(other) ||
      paper_win?(other) ||
      scissors_win?(other) ||
      lizard_win?(other) ||
      spock_win?(other)
  end

  def rock_lose?(other)
    rock? && (other.paper? || other.spock?)
  end

  def paper_lose?(other)
    paper? && (other.scissors? || other.lizard?)
  end

  def scissors_lose?(other)
    scissors? && (other.rock? || other.spock?)
  end

  def lizard_lose?(other)
    lizard? && (other.rock? || other.scissors?)
  end

  def spock_lose?(other)
    spock? && (other.paper? || other.lizard?)
  end

  def <(other)
    rock_lose?(other) ||
      paper_lose?(other) ||
      scissors_lose?(other) ||
      lizard_lose?(other) ||
      spock_lose?(other)
  end

  def to_s
    @value
  end
end

# Player
class Player
  attr_accessor :move, :name, :scores

  def initialize
    set_name
    @scores = 0
  end
end

# human
class Human < Player
  def set_name
    n = ''
    loop do
      puts "What's your name?"
      n = gets.chomp
      break unless n.empty?
      puts 'Sorry, must enter a value.'
    end
    self.name = n
  end

  def choose
    choice = nil
    loop do
      puts 'Please choose 1.rock, 2.paper, 3.scissors, 4.spock 5.lizard'
      puts 'Please input number 1, 2, 3, 4 or 5:'
      input = gets.chomp.to_i
      choice = RPS[input - 1] if [1, 2, 3, 4, 5].include? input
      break if RPS.include? choice
      puts 'Sorry, invalid choice.'
    end
    self.move = Move.new(choice)
  end
end

# computer
class Computer < Player
  def set_name
    self.name = ['R2D2', 'Hal', 'Chappie', 'Sonny', 'No. 5'].sample
  end

  def choose
    self.move = Move.new(RPS.sample)
  end
end

# RPS
class RPSGame
  include Scores

  attr_accessor :human, :computer
  POINTS = 3

  def initialize
    @human = Human.new
    @computer = Computer.new
  end

  def display_welcome_message
    puts 'Welcome to Rock, Paper, Scissors, Spock, Scissors!'
  end

  def display_goodbye_message
    puts 'Thans for playing Rock, Paper, Scissors, Spock, Scissors. Good bye!'
  end

  def display_moves
    puts "#{human.name} chose #{human.move}."
    puts "#{computer.name} chose #{computer.move}."
  end

  def winner?
    (human.scores >= POINTS) || (computer.scores >= POINTS)
  end

  def display_winner
    com_s = computer.scores
    hum_s = human.scores

    if com_s == POINTS && hum_s == POINTS
      puts "It's a tie!"
    elsif com_s >= POINTS
      puts "#{computer.name} won!"
    else
      puts "#{human.name} won!"
    end
  end

  def play_again?
    answer = nil
    loop do
      puts 'Would you like to play again? (y/n)'
      answer = gets.chomp.downcase
      break if %w[y n].include? answer.downcase
      puts 'Sorry, must be y or n.'
    end

    return false if answer == 'n'
    return true if answer == 'y'
  end

  def play_round
    clear_scores
    loop do
      human.choose
      computer.choose
      display_moves
      keep_scores
      display_scores
      break if winner?
    end
  end

  def play
    display_welcome_message
    loop do
      play_round
      display_winner
      break unless play_again?
    end
    display_goodbye_message
  end
end

RPSGame.new.play

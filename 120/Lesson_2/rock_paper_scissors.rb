# This is rock paper scissors game
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
  RPS = %w[rock paper scissors].freeze

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

  def >(other)
    (rock? && other.scissors?) ||
      (paper? && other.rock?) ||
      (scissors? && other.paper?)
  end

  def <(other)
    (rock? && other.paper?) ||
      (paper? && other.scissors?) ||
      (scissors? && other.rock?)
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
      puts 'Please choose rock, paper, or scissors'
      choice = gets.chomp
      break if Move::RPS.include? choice
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
    self.move = Move.new(Move::RPS.sample)
  end
end

# main RPS
class RPSGame
  include Scores

  attr_accessor :human, :computer
  POINTS = 3

  def initialize
    @human = Human.new
    @computer = Computer.new
  end

  def display_welcome_message
    puts 'Welcome to Rock, Paper, Scissors!'
  end

  def display_goodbye_message
    puts 'Thans for playing Rock, Paper, Scissors. Good bye!'
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

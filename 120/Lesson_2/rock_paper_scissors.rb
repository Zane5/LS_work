# This is rock paper scissors game
# create class Scores
# Add Lizard and Spock
#
RPS = %w[rock paper scissors spock lizard].freeze

# class Scores
class Scores
  attr_reader :points

  def initialize
    @points = 0
    @round = 0
    @win_round = 0
    @lose_round = 0
    @tie_round = 0
  end

  def add_point
    @points += 1
    @win_round += 1 if @points == 10
  end

  def clear_points
    @points = 0
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

  def to_s
    @value
  end
end

# class Rock
class Rock < Move
  def initialize
    @value = 'rock'
  end

  def >(other)
    other.scissors? || other.lizard?
  end

  def <(other)
    other.paper? || other.spock?
  end
end

# class Paper
class Paper < Move
  def initialize
    @value = 'paper'
  end

  def >(other)
    other.rock? || other.spock?
  end

  def <(other)
    other.scissors? || other.lizard?
  end
end

# class Scissors
class Scissors < Move
  def initialize
    @value = 'scissors'
  end

  def >(other)
    other.paper? || other.lizard?
  end

  def <(other)
    other.rock? || other.spock?
  end
end

# class Lizard
class Lizard < Move
  def initialize
    @value = 'lizard'
  end

  def >(other)
    other.paper? || other.spock?
  end

  def <(other)
    other.rock? || other.scissors?
  end
end

# class Spock
class Spock < Move
  def initialize
    @value = 'spock'
  end

  def >(other)
    other.rock? || other.scissors?
  end

  def <(other)
    other.paper? || other.lizard?
  end
end

# Player
class Player
  attr_accessor :move, :name, :scores

  def initialize
    set_name
    self.scores = Scores.new
  end
end

# human
class Human < Player
  def set_name
    n = ''
    loop do
      puts "What's your name?"
      n = gets.chomp.delete ' '
      break if n.index(/[a-z]/i)
      puts 'Sorry, must enter at least one word character, a-z...'
    end
    self.name = n
  end

  def assign_choice(choice)
    case choice
    when 'rock' then self.move = Rock.new
    when 'paper' then self.move = Paper.new
    when 'scissors' then self.move = Scissors.new
    when 'lizard' then self.move = Lizard.new
    when 'spock' then self.move = Spock.new
    end
  end

  def choose
    choice = nil
    loop do
      puts 'Please choose 1.rock, 2.paper, 3.scissors, 4.spock 5.lizard'
      puts 'Please input a number 1, 2, 3, 4 or 5:'
      input = gets.chomp.to_i
      choice = RPS[input - 1] if [1, 2, 3, 4, 5].include? input
      break if RPS.include? choice
      puts 'Sorry, invalid choice.'
    end
    assign_choice(choice)
  end
end

# computer
class Computer < Player
  def set_name
    self.name = ['R2D2', 'Hal', 'Chappie', 'Sonny', 'No. 5'].sample
  end

  def choose
    self.move = [Rock.new, Paper.new, Scissors.new,
                 Lizard.new, Spock.new].sample
  end
end

# RPS
class RPSGame
  attr_accessor :human, :computer

  # points per round
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
    (human.scores.points >= POINTS) || (computer.scores.points >= POINTS)
  end

  def display_won(player)
    puts "#{player.name} won!"
  end

  def display_winner
    c_p = computer.scores.points
    h_p = human.scores.points

    if c_p == POINTS && h_p == POINTS
      puts "It's a tie!"
    elsif c_p >= POINTS
      display_won(computer)
    else
      display_won(human)
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

  def add_one_point(player)
    player.scores.add_point
    puts "#{player.name} won and just added 1 point"
  end

  def keep_scores
    hum_mv = human.move
    com_mv = computer.move

    if hum_mv > com_mv
      add_one_point(human)
    elsif hum_mv < com_mv
      add_one_point(computer)
    else
      puts "All player isn't add any point."
    end
  end

  def display_points
    puts "#{human.name} get === #{human.scores.points} points ==="
    puts "#{computer.name} get === #{computer.scores.points} points ==="
  end

  def clear_points
    human.scores.clear_points
    computer.scores.clear_points
  end

  def play_round
    clear_points
    loop do
      human.choose
      computer.choose
      display_moves
      keep_scores
      display_points
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

# This is rock paper scissors game
# create class Scores
# Add Lizard and Spock
#

# class history
class History
  def initialize
    @history = []
  end

  def display
    @history.map(&:to_s)
  end

  def <<(move)
    @history << move
  end
end

# class Score
class Score
  attr_reader :points, :win_round

  def initialize
    @points = 0
    @win_round = 0
  end

  def add_point
    @points += 1
    @win_round += 1 if @points == RPSGame::POINTS
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
  attr_accessor :move, :name, :scores, :history
  RPS = %w[rock paper scissors spock lizard].freeze

  def initialize
    set_name
    self.scores = Score.new
    self.history = History.new
  end

  def keep_history(move)
    history << move
  end
end

# human
class Human < Player
  def set_name
    n = ''
    loop do
      puts "What's your name?"
      n = gets.chomp
      break if n.index(/[a-z]/i)
      puts 'Sorry, must enter at least one word character, a-z...'
    end
    self.name = n
  end

  def assign_choice(choice)
    self.move = case choice
                when 'rock' then self.move = Rock.new
                when 'paper' then self.move = Paper.new
                when 'scissors' then self.move = Scissors.new
                when 'lizard' then self.move = Lizard.new
                when 'spock' then self.move = Spock.new
                end
  end

  def display_input_tips
    puts '~~~~~~~~~~~~~~~~~',\
         'Please choose 1.rock, 2.paper, 3.scissors, 4.spock 5.lizard',\
         'Please input a number 1, 2, 3, 4 or 5:'
  end

  def input_choice(choice)
    display_input_tips

    choice = nil

    loop do
      input = gets.chomp.to_i
      choice = RPS[input - 1] if [1, 2, 3, 4, 5].include? input
      break if RPS.include? choice
      puts 'Sorry, invalid choice.'
    end

    choice
  end

  def choose
    choice = input_choice(choice)
    assign_choice(choice)
    keep_history(move)
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
    keep_history(move)
  end
end

# show info
module Display
  def display_welcome_message
    puts 'Welcome to Rock, Paper, Scissors, Spock, Scissors!'
  end

  def display_goodbye_message
    puts 'Thans for playing Rock, Paper, Scissors, Spock, Scissors. Good bye!'
  end

  def display_a_line
    puts '~~~~~~~~~~~~~~~~~'
  end
end

# RPS
class RPSGame
  include Display

  attr_accessor :human, :computer

  POINTS = 10 # Whoever reaches 10 points first wins

  def initialize
    @human = Human.new
    @computer = Computer.new
  end

  def display_moves
    puts "#{human.name} chose #{human.move}."
    puts "#{computer.name} chose #{computer.move}."
  end

  def winner?
    (human.scores.points >= POINTS) || (computer.scores.points >= POINTS)
  end

  def display_winner_name(player)
    puts "#{player.name} won this round!"
  end

  def display_winner
    c_p = computer.scores.points
    h_p = human.scores.points

    if c_p == POINTS && h_p == POINTS
      puts "It's a tie!"
    elsif c_p >= POINTS
      display_winner_name(computer)
    else
      display_winner_name(human)
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

    answer == 'y'
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
    display_a_line
    puts "#{human.name} get === #{human.scores.points} points ==="
    puts "#{computer.name} get === #{computer.scores.points} points ==="
  end

  def clear_points
    human.scores.clear_points
    computer.scores.clear_points
  end

  def display_history
    display_a_line
    puts "The history of #{human.name} is #{human.history.display}"
    puts "The history of #{computer.name} is #{computer.history.display}"
  end

  def display_win_round
    display_a_line
    puts "#{human.name} won #{human.scores.win_round} rounds!"
    puts "#{computer.name} won #{computer.scores.win_round} rounds!"
  end

  def play_round
    clear_points
    loop do
      human.choose
      computer.choose
      display_moves
      keep_scores
      display_points
      display_history
      break if winner?
    end
  end

  def play
    display_welcome_message
    loop do
      play_round
      display_winner
      display_win_round
      break unless play_again?
      system 'clear'
    end
    display_goodbye_message
  end
end

RPSGame.new.play

require 'pry'

SUITS = ['H', 'D', 'S', 'C'].freeze
VALUES = ['2', '3', '4', '5', '6', '7', '8', '9', '10',
          'J', 'Q', 'K', 'A'].freeze

def prompt(msg)
  puts "=> #{msg}"
end

def initialize_deck
  SUITS.product(VALUES).shuffle
end

def sum_with_aceses(c_vals, c_sum)
  # correct for Aces
  c_vals.select { |value| value == "A" }.count.times do
    c_sum -= 10 if c_sum > 21
  end
  c_sum
end

def total(cards)
  # cards = [['H', '3'], ['S', 'Q'], ... ]
  values = cards.map { |card| card[1] }

  sum = 0
  values.each do |value|
    sum += case value
           when "A"
             11
           when "J", "Q", "K" # J, Q, K
             10
           else
             value.to_i
           end
  end

  sum_with_aceses(values, sum)
end

def busted?(cards)
  total(cards) > 21
end

# :tie, :dealer, :player, :dealer_busted, :player_busted
def detect_result(dealer_cards, player_cards)
  player_total = total(player_cards)
  dealer_total = total(dealer_cards)

  if player_total > 21
    :player_busted
  elsif dealer_total > 21
    :dealer_busted
  elsif dealer_total < player_total
    :player
  elsif dealer_total > player_total
    :dealer
  else
    :tie
  end
end

def display_points(d_points, p_points)
  prompt ""
  prompt "$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$"
  prompt "$$   The Player points is #{p_points} / 5   $$"
  prompt "$$   The Dealer points is #{d_points} / 5   $$"
  prompt "$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$"
  prompt ""
end

def display_result(result, d_points, p_points)
  case result
  when :player_busted
    prompt ">>>>>> You busted! Dealer wins! <<<<<<"
  when :dealer_busted
    prompt ">>>>>> Dealer busted! You win! <<<<<<"
  when :player
    prompt ">>>>>> You win! <<<<<<"
  when :dealer
    prompt ">>>>>> Dealer wins! <<<<<<"
  when :tie
    prompt ">>>>>> It's a tie! <<<<<<"
  end

  display_points(d_points, p_points)
end

def play_again?
  prompt ">>>>>> Do you want to play again? (y or n) <<<<<<"
  answer = gets.chomp
  answer.downcase.start_with?('y')
end

def player_hit_stay(phs_turn)
  loop do
    prompt "Would you like to (h)it or (s)tay?"
    phs_turn = gets.chomp.downcase
    break if ['h', 's'].include?(phs_turn)
    prompt "Sorry, must enter 'h' or 's'."
  end
  phs_turn
end

def player_turn!(p_cards, p_deck)
  loop do
    p_turn = nil

    p_turn = player_hit_stay(p_turn)

    if p_turn == 'h'
      p_cards << p_deck.pop
      prompt "You chose to hit!"
      prompt "Your cards are now: #{p_cards}"
      prompt "Your total is now: --= #{total(p_cards)} =--"
    end

    break if p_turn == 's' || busted?(p_cards)
  end
end

def dealer_turn!(d_cards, d_deck, p_cards)
  unless busted?(p_cards)
    prompt "Dealer turn..."

    loop do
      break if busted?(d_cards) || total(d_cards) >= 17

      prompt "Dealer hits!"
      d_cards << d_deck.pop
      prompt "Dealer's cards are now: #{d_cards}"
      prompt "Dealer total is now: --= #{total(d_cards)} =--"
    end
  end
end

def initial_deal(p_cards, d_cards, i_deck)
  2.times do
    p_cards << i_deck.pop
    d_cards << i_deck.pop
  end
end

def player_deck(p_cards, d_cards)
  prompt "Dealer has #{d_cards[0]} and ?"
  prompt "You have: #{p_cards[0]} and #{p_cards[1]}, " \
         "for a total of --= #{total(p_cards)} =--."
end

def round_ending(result, d_cards, p_cards, d_points, p_points)
  unless busted?(d_cards) || busted?(p_cards)
    p_total = total(p_cards)
    d_total = total(d_cards)

    prompt ">>>>>>  You stayed at --== #{p_total} ==--"
    prompt ">>>>>>  Dealer stayed at --== #{d_total} ==--"

    puts "=============="
    prompt "Dealer has #{d_cards}, for a total of: --== #{d_total} ==--"
    prompt "Player has #{p_cards}, for a total of: --== #{p_total} ==--"
    puts "=============="
  end
  display_result(result, d_points, p_points)
end

loop do
  prompt "$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$"
  prompt "$$  Welcome to Twenty-One!  $$"
  prompt "$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$"

  player_points = dealer_points = 0

  while player_points < 5 && dealer_points < 5
    # initialize vars
    deck = initialize_deck
    player_cards = []
    dealer_cards = []

    initial_deal(player_cards, dealer_cards, deck)

    player_deck(player_cards, dealer_cards)

    player_turn!(player_cards, deck)
    dealer_turn!(dealer_cards, deck, player_cards)

    result = detect_result(dealer_cards, player_cards)

    player_points += 1 if result == :dealer_busted || result == :player
    dealer_points += 1 if result == :player_busted || result == :dealer

    round_ending(result, dealer_cards, player_cards,
                 dealer_points, player_points)
  end

  break unless play_again?
end

prompt "Thank you for playing Twenty-One! Good bye!"

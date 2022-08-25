require './lib/turn'
require './lib/player'
require './lib/deck'
require './lib/card'
require './lib/constants'

class Game
  attr_reader :player1, :player2, :deck, :state, :turns, :winner

  def initialize(p1_name = "Megan", p2_name = "Aurora", full_deck = STANDARD_DECK)
    @deck = Deck.new(full_deck.shuffle)
    p1_deck = Deck.new(deck.cards[0..25])
    p2_deck = Deck.new(deck.cards[26..-1])

    @player1 = Player.new(p1_name, p1_deck)
    @player2 = Player.new(p2_name, p2_deck)

    @state = :not_started
    @turns = []
    @winner = nil
  end

  def start(log_output = true)
    turn_count = 0

    until player1.has_lost? || player2.has_lost? || turn_count == 1000000
      turn = Turn.new(player1, player2)
      turn.pile_cards
      turn.award_spoils unless turn.winner == 'No winner'
      turns << turn.outcome
      turn_count+= 1
    end

    @state = :completed

    if log_output
      log_turns
      log_winner
    else
      puts "Game over after #{turn_count} turns"
    end
  end

  def start_message
    puts "Welcome to War! (or Peace) This game will be played with #{deck.cards.length} cards.\nThe players today are #{player1.name} and #{player2.name}.\nType 'GO' to start the game!\n------------------------------------------------------------------"
  end

  def log_turns
    turns.each_with_index do |turn, i|
      if turn[:type] == :mutually_assured_destruction
        puts "TURN #{i+1}: *mutually assured destruction* 6 cards removed from play"
      else
        puts "TURN #{i+1}: #{turn[:type] == :war ? 'WAR - ' : ''}#{turn[:winner]&.name} won #{turn[:spoils].length} cards."
      end
    end
  end

  def log_winner
    winner = player2 if player1.has_lost?
    winner = player1 if player2.has_lost?

    if winner
      puts "*~*~*~* #{winner.name} has won the game! *~*~*~*"
    else
      puts "---- DRAW ----"
    end
  end
end
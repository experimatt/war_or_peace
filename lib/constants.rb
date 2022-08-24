require './lib/card'
require './lib/deck'

SUITS = [:clubs, :diamonds, :spades, :hearts]

CARD_RANKS = {
  '2':2,
  '3':3,
  '4':4,
  '5':5,
  '6':6,
  '7':7,
  '8':8,
  '9':9,
  '10':10,
  'Jack':11,
  'Queen':12,
  'King':13,
  'Ace':14
}

STANDARD_DECK = SUITS.map do |suit|
  CARD_RANKS.map do |value, rank|
    Card.new(suit, value, rank)
  end
end.flatten
class Deck
  attr_reader :cards

  def initialize(cards = [])
    @cards = cards
  end

  def rank_of_card_at(index)
    cards[index]&.rank
  end

  def high_ranking_cards
    cards.select(&:high_ranking?)
  end

  def percent_high_ranking
    (high_ranking_cards.length / cards.length.to_f).round(4) * 100
  end

  def remove_card
    cards.shift
  end

  def add_card(card)
    cards << card
  end
end
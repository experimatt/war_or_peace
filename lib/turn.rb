require 'pry'

class Turn
  attr_reader :player1, :player2, :spoils_of_war

  # Future optimizations:
  #   1. Create separate turn classes based on type (e.g. BasicTurn, WarTurn, MutuallyAssuredDestructionTurn)

  def initialize(player1, player2)
    @player1 = player1
    @player2 = player2
    @spoils_of_war = []
  end

  def type
    if player1.deck.rank_of_card_at(0) != player2.deck.rank_of_card_at(0)
      :basic
    elsif player1.deck.rank_of_card_at(2) &&
          player2.deck.rank_of_card_at(2) &&
          player1.deck.rank_of_card_at(2) == player2.deck.rank_of_card_at(2)
      :mutually_assured_destruction
    else
      :war
    end
  end

  def winner
    if type == :mutually_assured_destruction
      return 'No winner'
    elsif type == :war
      player_with_higher_card_at(2)
    else
      player_with_higher_card_at(0)
    end
  end

  def pile_cards
    if type == :mutually_assured_destruction
      player1.deck.cards.shift(3) && player2.deck.cards.shift(3)
      nil
    elsif type == :war
      @spoils_of_war = [*player1.deck.cards.shift(3), *player2.deck.cards.shift(3)]
    else
      @spoils_of_war = [player1.deck.remove_card, player2.deck.remove_card]
    end
  end

  def award_spoils
    winner.deck.cards.push(*spoils_of_war) if spoils_of_war.any?
  end

  def outcome
    {
      winner: winner,
      type: type,
      spoils: spoils_of_war,
    }
  end

  # winner helper methods
  def player_with_higher_card_at(index)
    compare_cards_at(index) ? player1 : player2
  end

  def compare_cards_at(index)
    c1 = player1.deck&.rank_of_card_at(index)
    c2 = player2.deck&.rank_of_card_at(index)
    c1 && c2 && c1 > c2
  end
end
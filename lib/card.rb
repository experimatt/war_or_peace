class Card
  attr_reader :suit, :value, :rank

  # Future optimizations:
  #   1. Infer `rank` from `value`
  #   2. Validations on suit, rank, and value

  def initialize(suit, value, rank)
    @suit = suit
    @value = value
    @rank = rank
  end

  def high_ranking?
    rank > 10
  end
end
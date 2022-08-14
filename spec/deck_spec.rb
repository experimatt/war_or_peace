require 'rspec'
require './lib/deck'

describe Deck do
  let(:c1) { Card.new(:diamond, 'Queen', 12) }
  let(:c2) { Card.new(:spade, '3', 3) }
  let(:c3) { Card.new(:heart, 'Ace', 14)   }
  let(:cards) { [c1, c2, c3] }

  it 'exists' do
    deck = Deck.new([])
    expect(deck).to be_an_instance_of(Deck)
  end

  it 'has readable attributes' do
    deck = Deck.new(cards)

    expect(deck.cards).to eq(cards)
  end

  it 'defaults to an empty array' do
    deck = Deck.new()

    expect(deck.cards).to eq([])
  end

  describe '#rank_of_card_at' do
    it 'returns the card at index specified' do
      deck = Deck.new(cards)

      expect(deck.rank_of_card_at(1)).to eq(c2.rank)
    end

    it "returns nil if index doesn't exist" do
      deck = Deck.new(cards)

      expect(deck.rank_of_card_at(4924)).to be_nil
    end

    it 'works with negative indices' do
      deck = Deck.new(cards)

      expect(deck.rank_of_card_at(-1)).to eq(c3.rank)
      expect(deck.rank_of_card_at(-3)).to eq(c1.rank)
    end
  end

  describe '#high_ranking_cards' do
    it 'returns cards with value > 10' do
      deck = Deck.new(cards)

      expect(deck.high_ranking_cards).to eq([c1, c3])
    end

    it 'returns an empty array when no high cards present' do
      deck = Deck.new([c2])

      expect(deck.high_ranking_cards).to eq([])
    end
  end

  describe '#percent_high_ranking' do
    it 'returns a percentage value' do
      deck = Deck.new(cards)

      expect(deck.percent_high_ranking).to eq(66.67)
    end

    it 'returns zero if no high cards present' do
      deck = Deck.new([c2])

      expect(deck.percent_high_ranking).to eq(0)
    end
  end

  describe '#remove_card' do
    it 'removes the first card' do
      deck = Deck.new(cards)

      expect(deck.remove_card).to eq(c1)
      expect(deck.cards).to eq([c2, c3])
    end

    it 'returns nothing when deck is empty' do
      deck = Deck.new([])

      expect(deck.remove_card).to be_nil
      expect(deck.cards).to eq([])
    end
  end

  describe '#add_card' do
    it 'adds a card to the end' do
      deck = Deck.new(cards)
      c4 = Card.new(:clubs, 'Two', 2)

      deck.add_card(c4)

      expect(deck.cards).to eq([c1, c2, c3, c4])
    end
  end
end
require 'rspec'
require './lib/player'
require './lib/deck'
require './lib/card'

describe Player do
  let(:c1) { Card.new(:diamond, 'Queen', 12) }
  let(:c2) { Card.new(:spade, '3', 3) }
  let(:c3) { Card.new(:heart, 'Ace', 14)   }
  let(:deck) { Deck.new([c1, c2, c3]) }

  it 'exists' do
    player = Player.new('boop', Deck.new)
    expect(player).to be_an_instance_of(Player)
  end

  it 'has readable attributes' do
    player = Player.new('boop', deck)

    expect(player.name).to eq('boop')
    expect(player.deck).to eq(deck)
  end

  describe '#has_lost?' do
    it 'returns false when deck has cards' do
      player = Player.new('boop', deck)

      expect(player.has_lost?).to eq(false)
    end

    it 'returns true when deck has no cards' do
      player = Player.new('boop', Deck.new)

      expect(player.has_lost?).to eq(true)
    end
  end

end
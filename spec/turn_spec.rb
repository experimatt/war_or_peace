require 'rspec'
require './lib/turn'
require './lib/player'
require './lib/deck'
require './lib/card'

describe Turn do
  let(:c1) { Card.new(:diamond, 'Queen', 12) }
  let(:c2) { Card.new(:spade, '3', 3) }
  let(:c3) { Card.new(:heart, 'Ace', 14)   }
  let(:d1) { Deck.new([c1, c2, c3]) }
  let(:p1) { Player.new('Anthony', d1) }

  let(:c4) { Card.new(:club, 'Jack', 11) }
  let(:c5) { Card.new(:spade, '7', 7) }
  let(:c6) { Card.new(:diamond, '10', 10)   }
  let(:d2) { Deck.new([c4, c5, c6]) }
  let(:p2) { Player.new('Matt', d2) }

  it 'exists' do
    turn = Turn.new(p1, p2)
    expect(turn).to be_an_instance_of(Turn)
  end

  it 'has readable attributes' do
    turn = Turn.new(p1, p2)

    expect(turn.player1).to eq(p1)
    expect(turn.player2).to eq(p2)
    expect(turn.spoils_of_war).to eq([])
  end

  describe '#type' do
    describe "when first cards don't match" do
      it 'is basic when both cards are present' do
        turn = Turn.new(p1, p2)
  
        expect(turn.type).to eq(:basic)
      end

      it 'is basic when one of the cards is nil' do
        p3 = Player.new('Blank', Deck.new([]))
        turn = Turn.new(p1, p3)
  
        expect(turn.type).to eq(:basic)
      end
    end

    describe 'when first cards match' do
      it "is war when third cards don't match" do
        war_deck = Deck.new([c1, c3, c4])
        p3 = Player.new('Amy', war_deck)
        turn = Turn.new(p1, p3)
  
        expect(turn.type).to eq(:war)
      end

      it "is still war when both third cards don't exist" do
        small_deck = Deck.new([c1])
        p3 = Player.new('Luke', small_deck)
        p4 = Player.new('Liz', small_deck)
        turn = Turn.new(p3, p4)
  
        expect(turn.type).to eq(:war)
      end

      it "is still war when one third card is nil" do
        small_deck = Deck.new([c1])
        p4 = Player.new('Marijke', small_deck)
        p6 = Player.new('Liz', d1)
        turn = Turn.new(p4, p6)
  
        expect(turn.type).to eq(:war)
      end

      it 'is mutually assured destruction when third cards also match' do
        turn = Turn.new(p1, p1)
  
        expect(turn.type).to eq(:mutually_assured_destruction)
      end
    end
  end

  describe '#winner' do
    describe 'basic turn' do
      it 'bases winner off first card' do
        turn = Turn.new(p1, p2)

        expect(turn.winner).to eq(p1)
      end
    end

    describe 'war turn' do
      it 'bases winner off third card' do
        war_deck = Deck.new([c1, c3, c4])
        p3 = Player.new('Amy', war_deck)
        turn = Turn.new(p1, p3)

        expect(turn.winner).to eq(p1)
      end
    end

    describe 'mutually assured destruction turn' do
      it 'returns "No winner"' do
        turn = Turn.new(p1, p1)

        expect(turn.winner).to eq('No winner')
      end
    end
  end

  describe '#pile_cards' do
  end

  describe '#spoils_of_war' do
  end

  describe '#award_spoils' do
  end
end
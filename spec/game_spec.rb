require 'rspec'
require './lib/game'

describe Game do
  let(:game) { Game.new('Anthony', 'Matt') }
  it 'exists' do
    expect(game).to be_an_instance_of(Game)
  end

  it 'has readable attributes' do
    expect(game.player1.name).to eq('Anthony')
    expect(game.player2.name).to eq('Matt')
    expect(game.deck.cards.length).to eq(52)
    expect(game.state).to eq(:not_started)
    expect(game.turns).to eq([])
  end

  it 'shuffles and splits the deck' do
    expect(game.deck.cards.length).to eq(52)
    expect(game.player1.deck.cards.length).to eq(26)
    expect(game.player2.deck.cards.length).to eq(26)
  end

  describe '#start' do
    it 'changes states' do
      expect { game.start }.to change(game, :state)
        .from(:not_started).to(:completed)
    end

    it 'does not log output by default' do
      expect(game.turns.empty?).to eq(true)

      game.start

      expect(game.turns.any?).to eq(true)

    end

    it 'logs turn outcomes' do
      expect(game.turns.empty?).to eq(true)

      game.start(true)

      expect(game.turns.any?).to eq(true)
    end
  end
end
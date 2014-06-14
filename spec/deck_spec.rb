require_relative '../lib/deck.rb'

describe Deck do
  subject(:cards) { Deck.new }
  describe '#shuffle' do
    it 'returns a deck of 52 unique cards' do
      expect(cards.shuffle.uniq.size).to eq(52) 
    end
  end
  
  describe '#draw' do
    #set top of deck to be some card
    
    it 'returns the top of the deck' do
      card = Card.new('h', 6)
      cards.deck[-1] = card
      expect(cards.draw).to eql(card)
    end
    
    it 'returns many cards' do
      card1 = Card.new('h', 6)
      card2 = Card.new('s', 7)
      cards.deck << card1 
      cards.deck << card2
      expect(cards.draw).to eql(card2)
      expect(cards.draw).to eql(card1)
    end
  end

end
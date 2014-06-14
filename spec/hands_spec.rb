require_relative '../lib/hands.rb'

describe Hand do
   
 
  
  card1 = Card.new('h', 3)
  card2 = Card.new('h', 4)    
  card3 = Card.new('h', 5)
  card4 = Card.new('h', 6)
  card5 = Card.new('h', 7)
  card6 = Card.new('s', 8)
  card7 = Card.new('s', 11)
  card8 = Card.new('s', 12)
  card9 = Card.new('s', 13)
  card10 = Card.new('s',14)
  card11 = Card.new('s', 10)
  
  card7b = Card.new('s', 3)
  card8b = Card.new('s', 5)
  card9b = Card.new('s', 7)
  card10b = Card.new('c',14)
  card11b = Card.new('s', 11)
  
          
    
  let(:straight_flush) { Hand.new([card1, card2, card3, card4, card5]) }
  let(:four_in_a_row) { Hand.new(Array.new(4, card1) + [card6])}
  let(:straight) { Hand.new([card2, card3, card4, card5, card6]) }
  let(:flush) {Hand.new([card6, card8, card9, card10, card11])}
  let(:royal_flush) {Hand.new([card11, card7, card8, card9, card10])}
  let(:pair) {Hand.new([card1, card1, card8, card9, card10])}
  let(:three_of_a_kind) {Hand.new([card1, card1, card1, card9, card10])}
  let(:full_house) {Hand.new([card1, card1, card1, card9, card9])}
  let(:four_of_a_kind) {Hand.new([card1, card1, card1, card1, card10])}
  let(:high_card) {Hand.new([card1, card3, card5, card7, card10])}
  let(:low_card) {Hand.new([card1, card3, card5, card7, card8])}
  let(:two_pair) {Hand.new([card1, card1, card3, card3, card7])}
  let(:club_high) {Hand.new([card11b, card7b, card8b, card9b, card10b])}
  
  describe '#flush?' do
    it 'correctly identifies a flush' do
      expect(straight_flush.flush?).to be true
    end
    
    it 'correctly rejects a non flush' do 
      expect(four_in_a_row.flush?).to be false
    end
  end  

  describe '#straight?' do
    it  'correctly identifies a straight' do
      expect(straight.straight?).to be true
    end
    
    it 'correctly rejects a non-straight' do 
      expect(four_in_a_row.straight?).to be false
    end
  end
  
  describe '#straight_flush?' do
    it 'identifies a straight flush' do
      expect(straight_flush.straight_flush?).to be true
    end
    
    it 'rejects straights' do
      expect(straight.straight_flush?).to be false
    end
    
    it 'rejects flushes' do
      expect(flush.straight_flush?).to be false
    end
    
  end
  
  describe '#royal_flush?' do 
    it 'identifies a royal flush' do
      expect(royal_flush).to be_royal_flush
    end
    
    it 'rejects straights' do
      expect(straight.royal_flush?).to be false
    end
    
    it 'rejects flushes' do
      expect(flush.royal_flush?).to be false
    end 
  end
  
  describe '#pair?' do
    it 'identifies a pair' do
      expect(pair.pair?).to be_truthy
    end
    
    it 'rejects non pairs' do
      expect(high_card.pair?).to be_falsy
    end
  end
  
  describe '#two_pairs?' do
    it 'identifies two pairs' do 
      expect(two_pair).to be_two_pairs
    end
    
    it 'rejects non two pairs' do
      expect(pair).to_not be_two_pairs
    end
  end
   
  describe '#three_of_a_kind?' do
    it 'identifies three of a kind' do 
      expect(three_of_a_kind).to be_three_of_a_kind
    end
    
    it 'correctly rejects non-three of a kinds' do 
      expect(pair).to_not be_three_of_a_kind
    end
  end
  
  describe '#full_house' do
    it 'identifies full houses' do
      expect(full_house).to be_full_house
    end
    
    it 'rejects non full houses' do 
      expect(two_pair).to_not be_full_house
    end
  end

  describe '#four_of_a_kind' do
    it 'identifies four_of_a_kind' do
      expect(four_of_a_kind).to be_four_of_a_kind
    end
    
    it 'rejects non four of a kind' do
      expect(two_pair).to_not be_four_of_a_kind
    end
  end
   
  describe '#high_card' do
    it 'should return the high-card' do
      expect(high_card.high_card?).to be 14
    end
  end
  
  describe '#beats' do
    it 'royal flush beats all lower hands' do
      expect(royal_flush.beats(straight_flush)).to be true
    end
    
    it 'straight flush beats all lower hands' do
      expect(straight_flush.beats(four_of_a_kind)).to be true
    end
    
    it 'four of a kind beats all lower hands' do
      expect(four_of_a_kind.beats(full_house)).to be true
    end
    
    it 'full house beats all lower hands' do
      expect(full_house.beats(flush)).to be true
    end
    
    it 'flush beats all lower hands' do
      expect(flush.beats(straight)).to be true
    end
    
    it 'straight beats all lower hands' do
      expect(straight.beats(three_of_a_kind)).to be true
    end
    
    it 'three of a kind beats all lower hands' do
      expect(three_of_a_kind.beats(two_pair)).to be true
    end
    
    it 'two pair beats all lower hands' do
      expect(two_pair.beats(pair)).to be true
    end
    
    it 'pair beats all lower hands' do
      expect(pair.beats(high_card)).to be true
    end
    
    it 'high card beats lower cards' do
      expect(high_card.beats(low_card)).to be true
    end
  
    it 'uses suits to break ties' do 
      expect(high_card.beats(club_high)).to be true
    end
    
  end  
end

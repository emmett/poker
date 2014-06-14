load 'deck.rb'
load 'card.rb'
require 'debugger'
class Hand
  attr_reader :hand
  HAND_VALUES = {
    royal_flush?: 10,
    straight_flush?: 9,
    four_of_a_kind?: 8,
    full_house?: 7,
    flush?: 6,
    straight?: 5,
    three_of_a_kind?: 4,
    two_pairs?: 3,
    pair?: 2,
    high_card?: 1,    
  }
  def initialize(cards)
    @hand = cards.sort_by { |suit, value| value }
  end
  
  def flush?
    Card.SUITS.values.any? do |suit|
      @hand.all? { |card| card.suit == suit }
    end
  end
  
  # def self.HAND_VALUES
  #   return HAND_VALUES
  # end
  
  def straight?
    (0..3).all? { |i| @hand[i].value == (@hand[i + 1].value - 1) }
  end
  
  def straight_flush?
    flush? && straight?
  end
  
  def royal_flush?
    straight_flush? && @hand.last.value == 14
  end
  
  def pair?
    (0..3).find{ |i| @hand[i].value == @hand[i + 1].value }
    # (0..3).each do |i|
    #   (i + 1..4).each do |j|
    #     return @hand[i].value if @hand[i].value == @hand[j].value
    #   end
    # end
    # nil
  end
  
  def three_of_a_kind?
    self.vals.any?{ |val| self.vals.count(val) >= 3 }
    # (0..2).each do |i|
    #   return @hand[i].value if @hand[i].value == @hand[i + 2].value
    # end
    # nil
  end
  
  
  
  def vals
    @hand.map{ |card| card.value }
  end
  
  def suits
    @hand.map{ |card| card.suit }
  end
  
  def two_pairs?
    if @hand[0].value == @hand[1].value && @hand[2].value == @hand[3].value
      return [@hand[0].value, @hand[2].value]
    elsif @hand[0].value == @hand[1].value && @hand[3].value == @hand[4].value
      return [@hand[0].value, @hand[3].value]
    elsif @hand[1].value == @hand[2].value && @hand[3].value == @hand[4].value
      return [@hand[1].value, @hand[3].value]
    else
      nil
    end
  end
  
  def full_house?
    two_pairs? && three_of_a_kind? 
  end
  
  def four_of_a_kind?
    pairs = two_pairs? 
    pairs.nil? ? nil : pairs[0] == pairs[1]
  end
  
  def high_card?
    return @hand.last.value
  end
  
  def beats(opponent)
    our_score = self.score
    their_score = opponent.score
    if our_score != their_score
      self.score > their_score
    else
      break_high_card(@hand, opponent.hand)
    end
  end
  
  def score
    values = HAND_VALUES.to_a
    values.each do |hand, value|
      return value if self.send(hand)
    end
  end
  
  def break_tie(hand)
    
  end

  
  def break_high_card(hand)
    
  end
  
 
  private
  def break_high_card(our_hand, their_hand)
   # debugger
    (our_hand.size - 1).downto(0) do |i|
      if our_hand[i].value == their_hand[i].value
        next
      else
        return our_hand[i].value > their_hand[i].value
      end
    end
    (our_hand.size - 1).downto(0) do |i|
      if our_hand[i].suit == their_hand[i].suit
        next
      else
        return our_hand[i].suit > their_hand[i].suit
      end
    end       
  end
end
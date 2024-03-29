load 'deck.rb'
load 'card.rb'

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
  end
  
  def three_of_a_kind?
    self.vals.any?{ |val| self.vals.count(val) >= 3 }
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
    elsif four_of_a_kind? || full_house? || three_of_a_kind? 
      @hand[2].value > opponent.hand[2].value
    elsif two_pairs?
      break_tie_two_pair(opponent)
    elsif pair?
      break_tie_pair(opponent)
    else
      break_high_card(@hand, opponent.hand)
    end
  end
  
  def break_tie_two_pair(opponent)
    our_nums = two_pairs?
    their_nums = opponent.two_pairs?
    if our_nums[1] != their_nums[1]
      return our_nums[1] > their_nums[1]
    end
    if our_nums[0] != their_nums[0]
      return our_nums[0] > their_nums[0]
    end
    break_high_card(@hand, opponent.hand)
  end
  
  def break_tie_pair(opponent)
    our_ndx = self.pair?
    their_ndx = opponent.pair?
    if @hand[our_ndx].value != opponent.hand[their_ndx].value
      return @hand[our_ndx].value > opponent.hand[their_ndx].value
    end
    break_high_card(@hand, opponent.hand)
  end
  
  def score
    values = HAND_VALUES.to_a
    values.each do |hand, value|
      return value if self.send(hand)
    end
  end
  
 
  private
  def break_high_card(our_hand, their_hand)
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
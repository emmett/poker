class Card
  VALUES = (2..14).to_a
  SUITS = { spades: 's', hearts: 'h', clubs: 'c', diamonds: 'd' }
  attr_accessor :suit, :value
  
  def initialize(suit, value)
    @suit = suit
    @value = value
  end
  
  def self.VALUES
    VALUES
  end
  
  def self.SUITS
    SUITS
  end
end


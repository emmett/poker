class Deck
  attr_reader :deck
  def initialize
    @deck = []
    Card.VALUES.each do |value|
      Card.SUITS.each do |suit|
        @deck << Card.new(suit, value)
      end
    end
  end
  
  def shuffle
    @deck.shuffle!
  end
  
  def draw
    @deck.pop
  end
end
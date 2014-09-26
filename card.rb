class Card
attr_reader :definition
  def initialize(definition, term)
    @definition = definition
    @term = term
  end

  def correct?(answer)
    @term == answer
  end

  def self.create_deck
    temp = []
    deck = []
    File.open('flashcard_samples.txt').each do |line|
      if line == "\n"
        deck << Card.new(temp[0], temp[1])
        temp = []
      else
        temp << line
      end
    end
    deck
  end
end

deck = Card.create_deck
deck.each do |card|

  puts card.definition
end
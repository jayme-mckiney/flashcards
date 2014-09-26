class Card
attr_reader :definition, :term
  def initialize(definition, term)
    @definition = definition
    @term = term
    @score = 0
  end

  def correct?(answer)
    @term == answer
  end

end

class Deck

  def initialize files
    @deck = []
    files.each do |file|
      @deck.concat Deck.make_cards file
    end
  end

  # read the contents of the file and creating an array of cards from it
  def self.make_cards file
    temp = []
    deck = []
    File.open(file).each do |line|
      if line == "\n"
        deck << Card.new(temp[0], temp[1])
        temp = []
      else
        temp << line.chomp
      end
    end

    deck
  end

  def check_card answer
    @deck.first.correct?(answer)
  end

  def next
    @deck.rotate!
  end

  def shuffle!
    @deck.shuffle!
  end

  def read_card
    show_definition(@deck.first)
  end

  def show_definition(card)
    card.definition
  end

end
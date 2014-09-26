# @deck = [obj_card, obj_card, .... ]

class Controller
  def initialize
    @deck = Card.create_deck
    @stop = false
  end

  def stop!
    @stop = true
  end

  def run!
    @deck.shuffle!
    until @stop == true
      puts @deck.first.definition
      user_input = gets.chomp
      if user_input == "stop"
        stop!
      elsif user_input == "skip"
        @deck.rotate!
        puts "skipped!"
      elsif @deck.first.correct?(user_input)
        @deck.rotate!
        puts "Goodjob! You got it."
      else
        puts "Incorrect! Try again."
      end
    end
  end

end

controller = Controller.new

controller.run!
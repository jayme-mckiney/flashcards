# @deck = [obj_card, obj_card, .... ]
require_relative "./card.rb"
class Controller
  include View
  def initialize
    @names = nil
    @stop = false
  end

  def stop!
    @stop = true
  end

  def run!
    files = ARGV
    @names = files.map {|file| file.gsub(/.txt|.csv/,"")}
    deck = Deck.new(files)
    View.start
    until @stop == true
      user_input = gets.chomp
      if user_input == "stop!"
        stop!
        View.stop
      elsif user_input == "skip!"
        deck.next
        View.skip
      elsif user_input == "command!"
        View.command
      elsif user_input == "shuffle!"
        deck.shuffle!
        View.shuffle
      end
      elsif deck.check_card(user_input)
        deck.next
        View.correct
      else
        View.incorrect
      end
    end
  end

  module View
    def start
      puts "Welcome to the SuperEgo Flashcard Game!!!"
      puts "You are now being intimidated by the '#{@names}' deck!!!"
      puts "Here is your first SuperEgo attack! (don't know the answer?)"
      deck.read_card
      self.command
    end

    def stop
      puts "SuperEgo Flashcard Game Ended"
    end

    def skip
      puts "awww you can't answer that???"
    end

    def correct
      puts ""
    end

    def incorrect
      puts "Incorrect! Try again."
    end

    def shuffle
      puts "Shuffling your Ego"
    end

    def command
      puts "Enter 'stop!' to escape from SuperEgo."
      puts "Enter 'skip!' when you are not good enough for the problem."
      puts "Enter 'command!' to see all of the available commands"
      puts "Enter 'shuffle!' to shuffle your SuperEgo Flashcards'
    end
  end

  # def run!
  #   @deck.shuffle!
  #   until @stop == true
  #     puts @deck.first.definition
  #     user_input = gets.chomp
  #     if user_input == "stop"
  #       stop!
  #     elsif user_input == "skip"
  #       @deck.rotate!
  #       puts "skipped!"
  #     elsif @deck.first.correct?(user_input)
  #       @deck.rotate!
  #       puts "Goodjob! You got it."
  #     else
  #       puts "Incorrect! Try again."
  #     end
  #   end
  # end

end

controller = Controller.new

controller.run!
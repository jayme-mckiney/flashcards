require 'pry'

# @deck = [obj_card, obj_card, .... ]
require_relative "./card.rb"

module View
  def self.start
    puts "Welcome to the SuperEgo Flashcard Game!!!"
    puts "You are now being intimidated by the '#{@names}' deck!!!"
    puts "Here is your first SuperEgo attack! (don't know the answer?)"
    self.command
  end

  def self.stop
    puts "SuperEgo Flashcard Game Ended"
  end

  def self.skip
    puts "awww you can't answer that???"
  end

  def self.correct
    puts "Lucky guess."
    puts ""
  end

  def self.incorrect
    puts "Incorrect! Try again."
  end

  def self.shuffle
    puts "Shuffling your Ego"
  end

  def self.command
    puts "Enter 'stop!' to escape from SuperEgo."
    puts "Enter 'skip!' when you are not good enough for the problem."
    puts "Enter 'command!' to see all of the available commands"
    puts "Enter 'shuffle!' to shuffle your SuperEgo Flashcards"
  end

  def self.show_card definition
    puts definition
  end
end



class Controller
  # include View
  def initialize
    @names = nil
    @stop = false
  end

  def stop!
    @stop = true
  end

  def run!
    files = ARGV
    # files = ['flashcard_samples.txt']
    @names = files.map {|file| file.gsub(/.txt|.csv/,"")}
    deck = Deck.new(files)
    View.start
    # user_input = gets.chomp
    until @stop == true
      View.show_card(deck.read_card)
      user_input = $stdin.gets.chomp
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
      elsif deck.check_card(user_input)
        deck.next
        View.correct
      else
        View.incorrect

      end
    end
  end
end



controller = Controller.new

controller.run!
require 'pry'

# @deck = [obj_card, obj_card, .... ]
require_relative "./card.rb"

module View
  def self.start(names)
    puts ""
    puts "Welcome to the SuperEgo Flashcard Game!!!"
    puts ""
    puts "You are now being intimidated by the '#{names.first}' deck!!!"
    puts ""
    puts "-" * 44
    puts "Here is your first SuperEgo attack! (don't know the answer?)"
    puts ""
    self.command
  end

  def self.stop
    puts "SuperEgo Flashcard Game Ended"
  end

  def self.skip
    puts "LOLz hahahahaha awww you can't answer that - you mad?!?!"
  end

  def self.correct
    puts "Lucky guess. Mommy helped you?"
    puts ""
  end

  def self.incorrect
    puts "Incorrect Idiot! Why are you even trying?"
  end

  def self.shuffle
    puts "Shuffling your Ego"
  end

  def self.command
    puts "Here is your SuperEgo Flashcard Commands:"
    puts "Enter 'stop!' to escape from SuperEgo."
    puts "Enter 'skip!' when you are not good enough for the problem."
    puts "Enter 'command!' to see all of the available commands"
    puts "Enter 'shuffle!' to shuffle your SuperEgo Flashcards"
    puts "Enter 'sort!' show your worst SuperEgo Weakness"
  end



  def self.show_card definition
    puts ""
    puts "Here is your definition"
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
    @names = files.map {|file| file.gsub(/.txt|.csv/,"")}
    deck = Deck.new(files)
    View.start(@names)
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
      elsif user_input == "sort!"
        deck.sort_by_score
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
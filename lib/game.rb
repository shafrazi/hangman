#Computer will load a word from the text file
#display a blank for each letter of the word
#prompt user for word or letter
#if user word equals game word game ends else game continues and prompt for input again
#if user letter matches any letter in word display blanks with matched letters
#else display blanks and used letters
#continue game until user guesses the correct word or no of chances are over

#classes: Game, View, Word
require_relative "word.rb"
require_relative "view.rb"

class Game
  attr_accessor :word, :view, :no_of_guesses, :user_input
  def initialize(dictionary_file)
    @word = Word.new(dictionary_file).word_gen
    @view = View.new(@word)
    @game_over = false
    @no_of_guesses = 6
    @user_input = ""
  end

  def start_game
    while !game_over
      puts "No of available guesses: #{@no_of_guesses}"
      view.display
      puts "Enter your guess:"
      @user_input = gets.chomp
      view.check_guess(@user_input)
      @no_of_guesses -= 1
    end
  end

  def game_over
    if user_input == word || no_of_guesses == 0 || view.display_word == word
      if user_input == word
        puts "Congratulations! Your last guess was correct!"
        puts view.display_word.split("").join(" ")
      elsif view.display_word == word
        puts "Congratulations! You successfully guessed the word!"
        puts view.display_word.split("").join(" ")
      elsif no_of_guesses == 0
        puts "You lose! You ran out of available guesses!"
        puts "Correct word is: #{word.split("").join(" ")}"
      end
      @game_over = true
    end
  end
end

dictionary_file = "dictionary.txt"
game = Game.new(dictionary_file)
game.start_game

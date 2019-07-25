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
require "json"

class Game
  attr_accessor :word, :view, :no_of_guesses, :user_input, :game_over, :user_input
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
    self.save_game
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

  def as_json
    {word: @word, view: {original_word: view.original_word, display_word: view.display_word, incorrect_guesses: view.incorrect_guesses, incorrect_no: view.incorrect_no}, game_over: @game_over, no_of_guesses: @no_of_guesses, user_input: @user_input}
  end

  def self.from_json(file, dictionary_file)
    json = File.read(file)
    data = JSON.parse(json)
    loaded_game = new(dictionary_file)
    loaded_game.word = data["word"]
    loaded_game.view.original_word = data["view"]["original_word"]
    loaded_game.view.display_word = data["view"]["display_word"]
    loaded_game.view.incorrect_guesses = data["view"]["incorrect_guesses"]
    loaded_game.view.incorrect_no = data["view"]["incorrect_no"]
    loaded_game.game_over = data["game_over"]
    loaded_game.no_of_guesses = data["no_of_guesses"]
    loaded_game.user_input = data["user_input"]
    return loaded_game
  end

  def save_game
    puts "Enter file name to save the game:"
    file_name = gets.chomp
    data = self.as_json
    File.write("#{file_name}#{".json"}", JSON.dump(data))
  end
end

dictionary_file = "dictionary.txt"
# game = Game.new(dictionary_file)
# game.start_game
# game.save_game

game = Game.from_json("save4.json", dictionary_file)
game.start_game

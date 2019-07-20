class Word
  attr_accessor :word_gen
  def initialize(dictionary_file)
    @word_gen = generate_word(dictionary_file)
  end

  def generate_word(dictionary_file)
    words_array = File.readlines(dictionary_file)
    word = ""
    while check_length(word)
      word = words_array[random_num(words_array)].chomp
    end
    return word
  end

  def random_num(array)
    rand(array.length)
  end

  def check_length(word)
    if word.length >= 5 && word.length < 12
      false
    else
      true
    end
  end
end

word_obj = Word.new("dictionary.txt")
p word_obj.word_gen

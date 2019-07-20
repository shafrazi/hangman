# row1 = "  |----|"
# row2 = "       |"
# row3 = "       |"
# row4 = "       |"
# row5 = "       |"
# row6 = "_______|"

def hide_word(word)
  "-" * word.length
end


word = "shafrazi"
display_word = hide_word(word)
# display_array = display_word.split("")
input = "a"

p display_word

word.split("").each_with_index do |letter, i|
  if letter == input
    display_word[i] = input
  end
end

p display_word

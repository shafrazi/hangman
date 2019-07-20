# row1 = "  |----|"
# row2 = "       |"
# row3 = "       |"
# row4 = "       |"
# row5 = "       |"
# row6 = "_______|"

def check_length(word)
  if word.length > 5 && word.length < 12
    false
  else
    true
  end
end

p check_length("shafrghgjgjgjgjgjg")

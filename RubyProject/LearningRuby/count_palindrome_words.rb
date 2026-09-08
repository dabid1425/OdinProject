# frozen_string_literal: true
def count_palindrome_words(sentence)
  words_in_sentence = sentence.split(" ")
  palindrome_words = words_in_sentence.select { |word| word == word.reverse && word.length > 1 }
  "palindromes in sentence #{palindrome_words.count}=>#{palindrome_words}"
end

puts count_palindrome_words("racecar is a word and so is level")
# => 2  (racecar, level)
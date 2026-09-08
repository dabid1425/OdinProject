# frozen_string_literal: true
def group_by_first_letter(words)
  result = {}
  words.each do |word|
    letter = word[0]
    result[letter] ||= []
    result[letter] << word
  end
  result
end

puts group_by_first_letter(["apple", "banana", "avocado", "blueberry", "cherry"])
# => { "a" => ["apple", "avocado"], "b" => ["banana", "blueberry"], "c" => ["cherry"] }
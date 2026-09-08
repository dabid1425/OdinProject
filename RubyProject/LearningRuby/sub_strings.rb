def substrings(string, dictionary)
  unless string.is_a?(String) && dictionary.is_a?(Array)
    puts 'Error: string must be a String and dictionary must be an Array'
    return nil
  end

  words = string.downcase.split(" ")
  result = Hash.new(0)
  downcased_dictionary = dictionary.compact.select { |w| w.is_a?(String) && !w.empty? }.map { |word| word.downcase }.uniq
  words.each do |word|
    downcased_dictionary.each do |dictionary_word|
      if word.include?(dictionary_word)
        result[dictionary_word] += 1
      end
    end
  end

  result
end

dictionary = ["below", "Down", "go", "Going", "horn", "how", "howdy", "it", "i", "low", "own", "part", "partner", "sit"]

puts substrings("Howdy partner, sit down! How's it going?", dictionary)
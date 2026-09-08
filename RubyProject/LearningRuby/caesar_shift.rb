def caesar_shift(text, shift)
  unless text.is_a?(String) && shift.is_a?(Integer)
    puts 'Error: text must be a String and shift must be an Integer'
    return nil
  end
  # 1. Convert the text into an array of characters (cannot call .ord here)
  text_to_letter_array = text.split('')
  coded_drd_array = text_to_letter_array.map { |letter|
    # Move .ord inside the loop so it evaluates one character at a time
    num = letter.ord
    if num.between?(65, 90) || num.between?(97, 122)
      # 2. Determine the alphabet base (65 for Uppercase, 97 for Lowercase)
      base = num.between?(65, 90) ? 65 : 97
      # 3. Apply the shift math and return the new character
      (((num - base) + shift) % 26 + base).chr
    else
      # If it's a space or punctuation, return the character unchanged
      letter
    end
  }
  # 4. Join the array of characters back into a finished string
  coded_drd_array.join('')
end

puts caesar_shift(nil, -1)
puts caesar_shift('What a string!', 5)
puts caesar_shift('My looooove! <3', 3)

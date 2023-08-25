def generate_sentence
  -> (data) do
    bigrams = data[:bigrams]
    trigrams = data[:trigrams]

    first_word = "anji"

    generate_next_words = -> (word) do
      ngrams = rand() > 0.2 ? bigrams : trigrams

      return nil unless ngrams[word]
      
      ngrams[word].keys.sample
    end

    generate_x_words = -> (count, acc) do
      return acc if count < 1
      
      next_words = generate_next_words.call(acc.last)
      return acc if next_words.nil?
      
      acc.push(*next_words)

      return generate_x_words.call(count - 1, acc)
    end
    
    words = generate_x_words.call(25, [first_word])

    return words.join(" ")
  end
end

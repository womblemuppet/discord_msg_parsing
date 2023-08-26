def generate_sentence
  -> (data) do
    bigrams = data[:bigrams]
    trigrams = data[:trigrams]

    first_word = bigrams.keys.sample

    generate_next_words = -> (word) do
      ngrams = rand() > 0.2 ? bigrams : trigrams

      return nil unless ngrams[word]
      
      word_tally = ngrams[word]
      words_frequency_array = word_tally.sum([]) { |word, frequency| [word] * frequency }

      return words_frequency_array.sample
    end

    generate_x_words = -> (count, acc) do
      return acc if count < 1
      
      if acc.last == :sentence_end
        return acc
      end

      next_words = generate_next_words.call(acc.last)
      return acc if next_words.nil?
      
      acc.push(*next_words)

      return generate_x_words.call(count - 1, acc)
    end
    
    words = generate_x_words.call(25, [first_word])

    format_sentence = -> (words) do
      words.each_with_index.sum("") do |word, i|
        next [".", ".",  "..."].sample if word == :sentence_end

        if i == 0
          next word 
        else
          next " " + word
        end
      end
      
    end

    return format_sentence.call(words)
  end
end

def make_ngrams
  -> (data) do
    bigrams = {}
    trigrams = {}

    data["messages"].each do |message_data|
      sentences = Language::chunk_into_sentences(message_data["content"].split)

      sentences.each do |sentence|
        next unless sentence.first.present?

        sentence.each_cons(2) do |raw_w1, raw_w2|
          break if raw_w1.in?(Language::stopwords)
          break unless [raw_w1, raw_w2].all? { |word| Language::is_valid_token?(word) }

          w1 = Language.clean_up_word(raw_w1)
          w2 = Language.clean_up_word(raw_w2)

          bigrams[w1] ||= {}
          bigrams[w1][w2] ||= 0
          bigrams[w1][w2] += 1
        end

        sentence.each_cons(3) do |raw_w1, raw_w2, raw_w3|
          break if raw_w1.in?(Language::stopwords)
          break unless [raw_w1, raw_w2, raw_w3].all? { |word| Language::is_valid_token?(word) }

          w1 = Language.clean_up_word(raw_w1)
          w2 = Language.clean_up_word(raw_w2)
          w3 = Language.clean_up_word(raw_w3)

          trigrams[w1] ||= {}
          trigrams[w1][[w2, w3]] ||= 0
          trigrams[w1][[w2, w3]] += 1
        end
      end

    end

    return {
      bigrams: bigrams,
      trigrams: trigrams
    }
  end
end

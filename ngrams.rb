def make_ngrams
  -> (data) do
    bigrams = {}
    trigrams = {}

    data["messages"].each do |message_data|
      sentences = Language::chunk_into_sentences(message_data["content"].split)

      sentences.each do |sentence|
        next unless sentence.first.present?

        sentence.each_cons(2) do |w1, w2|
          break unless Language::is_valid_token?(w2)

          bigrams[w1] ||= {}
          bigrams[w1][w2] ||= 0
          bigrams[w1][w2] += 1
        end

        sentence.each_cons(3) do |w1, w2, w3|
          break unless Language::is_valid_token?(w2) && Language::is_valid_token?(w3)

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
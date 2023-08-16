def make_ngrams
  -> (data) do
    bigrams = {}
    trigrams = {}

    data["messages"].each do |message_data|
      sentences = PragmaticSegmenter::Segmenter.new(text: message_data["content"]).segment()

      sentences.each do |sentence|
        words = sentence.split(/\W/)

        words.each_cons(2) do |w1, w2|
          break unless Stopwords::is_valid_token?(w2)

          bigrams[w1] ||= {}
          bigrams[w1][w2] ||= 0
          bigrams[w1][w2] += 1
        end

        words.each_cons(3) do |w1, w2, w3|
          break unless Stopwords::is_valid_token?(w2) && Stopwords::is_valid_token?(w3)

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
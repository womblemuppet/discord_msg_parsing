require_relative "language"

words = ["I", "now", "go.", "see", "ya!"]
p Language::chunk_into_sentences(words).to_a
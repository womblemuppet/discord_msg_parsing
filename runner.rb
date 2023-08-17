require "active_support/all"
require "json"

require_relative "language"
require_relative "ngrams"
require_relative "word_count"

class Runner
  def initialize(function)
    @function = function

    file = File.open("data/general.json")
    @data = JSON::parse(file.read())
  end

  def start
    start_time = Time.now()
    puts "Started #{start_time}"
    
    result = @function.call(@data)
    
    bigrams = result[:bigrams]
    trigrams = result[:trigrams]

    File.write("./data/bigrams.json", JSON::pretty_generate(bigrams))
    File.write("./data/trigrams.json", JSON::pretty_generate(trigrams))

    puts result
    puts "Finished. Total duration #{Time.now - start_time} seconds"
  end
  
end

Runner.new(make_ngrams).start()
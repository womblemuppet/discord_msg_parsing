require "active_support/all"
require "json"

require_relative "language"
require_relative "ngrams"
require_relative "word_count"
require_relative "generate_sentence"

class Runner
  def initialize(function)
    @function = function

    message_data_file = File.open("./data/general.json")
    @message_data = JSON::parse(message_data_file.read())

    @bigrams = if File.file?("./data/bigrams.rb")
      eval(File.read("./data/bigrams.rb"))
    else
       nil
    end

    @trigrams = if File.file?("./data/trigrams.rb")
      eval(File.read("./data/trigrams.rb"))
    else
      nil
    end
  end

  def start
    start_time = Time.now()
    puts "Started #{start_time}"
    
    result = @function.call(
      { 
        message_data: @message_data["messages"],
        bigrams: @bigrams,
        trigrams: @trigrams
      }
    )

    puts result
    puts "Finished. Total duration #{Time.now - start_time} seconds"
  end
  
end

Runner.new(generate_sentence).start()

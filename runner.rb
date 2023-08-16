require "active_support/all"
require "json"
require 'pragmatic_segmenter'

require_relative "stopwords"
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
    
    puts result
    puts "Finished. Total duration #{Time.now - start_time} seconds"
  end
  
end

Runner.new(make_ngrams).start()
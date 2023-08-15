require "active_support/all"
require "json"

require_relative "stopwords"

file = File.open("data/general.json")
data = JSON::parse(file.read())

start_time = Time.now()
puts "Started #{start_time}"

messages_tally = data["messages"].inject({}) do |acc, message_data|
  next acc.merge(message_data["content"].split.tally) { |key, v1, v2| (v1 || 0) + v2 }
end

result = messages_tally
  .select do |token, count|
    next false unless is_valid_token?(token)
    next false unless count > 10

    next true
  end
  .sort_by {| _token, value| value }
  .reverse
  .to_h

puts result
puts "Finished. Total duration #{Time.now - start_time} seconds"

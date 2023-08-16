def count_words
  -> (data) do
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

    return result
  end
end



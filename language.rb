module Language
  def self.chunk_into_sentences(words)
    words.each_with_object([[]]) do |word, acc|
      if word =~ Language::sentence_ending_matcher && word !~ Language::words_with_periods
        acc.last.push(word)
        # acc.last.push(:sentence_end) ##TBC
        acc.push([])
        next
      end

      acc.last.push(word)
    end
  end

  def self.is_valid_token?(word)
    return false if word !~ Language::valid_token_regex

    if word.length == 1 
      return word =~ /[iaou]/
    else
      return true
    end
  end

  def self.valid_token_regex
    /^[a-z]+$|^\w+\-\w+|^[a-z]+[0-9]+[a-z]+$|^[0-9]+[a-z]+|^[a-z]+[0-9]+$/
  end

  def self.stopwords
    # List from Ruby LLP list on github - "stopwords" 

    [
      # 'a','cannot','into','our','thus','about','co','is','ours','to','above',
      # 'could','it','ourselves','together','across','down','its','out','too',
      # 'after','during','itself','over','toward','afterwards','each','last','own',
      # 'towards','again','eg','latter','per','under','against','either','latterly',
      # 'perhaps','until','all','else','least','rather','up','almost','elsewhere',
      # 'less','same','upon','alone','enough','ltd','seem','us','along','etc',
      # 'many','seemed','very','already','even','may','seeming','via','also','ever',
      # 'me','seems','was','although','every','meanwhile','several','we','always',
      # 'everyone','might','she','well','among','everything','more','should','were',
      # 'amongst','everywhere','moreover','since','what','an','except','most','so',
      # 'whatever','and','few','mostly','some','when','another','first','much',
      # 'somehow','whence','any','for','must','someone','whenever','anyhow',
      # 'former','my','something','where','anyone','formerly','myself','sometime',
      # 'whereafter','anything','from','namely','sometimes','whereas','anywhere',
      # 'further','neither','somewhere','whereby','are','had','never','still',
      # 'wherein','around','has','nevertheless','such','whereupon','as','have',
      # 'next','than','wherever','at','he','no','that','whether','be','hence',
      # 'nobody','the','whither','became','her','none','their','which','because',
      # 'here','noone','them','while','become','hereafter','nor','themselves','who',
      # 'becomes','hereby','not','then','whoever','becoming','herein','nothing',
      # 'thence','whole','been','hereupon','now','there','whom','before','hers',
      # 'nowhere','thereafter','whose','beforehand','herself','of','thereby','why',
      # 'behind','him','off','therefore','will','being','himself','often','therein',
      # 'with','below','his','on','thereupon','within','beside','how','once',
      # 'these','without','besides','however','one','they','would','between','i',
      # 'only','this','yet','beyond','ie','onto','those','you','both','if','or',
      # 'though','your','but','in','other','through','yours','by','inc','others',
      # 'throughout','yourself','can','indeed','otherwise','thru','yourselves'
    ]
  end

  # Could not find gem that didn't split "I'm" etc as two different sentences
  def self.contractions
    /\w+'m|\w+'ve|\w+n't/i
  end

  def self.words_with_periods
    /[ap]\.m(?=.)/
  end

  def self.sentence_ending_matcher
    /[.!?]/
  end

  def self.clean_up_word(word)
    match = word.match(valid_token_regex)
    raise unless match

    return match[0].downcase
  end
end
module WordsHelper
  def linkTerms(word)
    linkedDefinition = word.definition #linkUpTerms(['a'],word.definition)
    # for each word in the system besides the current one
    # check the array of words in the current definition
    # if there's a match, link the matched definition word to the word
    Word.all.each do |word|
      linkedDefinition = linkUpTerms(word,linkedDefinition) unless word.word == 'A'
    end
    linkedDefinition.html_safe
  end

  def linkUpTerms(word, definition)
    word.matches.each do |term|
      # Rails.logger.info term if find_words(definition).include?(term)
      definition = definition.gsub( /\b#{term.downcase}\b/i, '<a href="/words/' + word.word.downcase + '" class="termLink">\0</a>') if matches?(term,definition)
    end
    definition
  end

  def matches?(term, definition)
    (find_words(definition) & [term]).present?
  end

  def find_words(definition)
    clean_up(definition).split(/[^a-zA-Z\']+/).uniq
  end

  def clean_up(definition)
    definition = strip_tags(definition).downcase
    definition.gsub!("&rsquo;","'")
    definition.gsub!("'s","")
    definition.gsub(/&[^\s]*;/, '')
  end

  def word_frequency
    words = Word.all
    freq = Hash.new(0)
    words.each do |current_word|
      words = find_words(clean_up(current_word.definition))
      temp = words.each { |word| freq[word] += 1 }
    end
    sorted = freq.sort_by { |k,v| v }.reverse
    render :partial => "word_stats", :collection => sorted
  end

  def link_back(term)
    Word.where("lower(word) = ?", term).first.nil? ? false : true
  end

end

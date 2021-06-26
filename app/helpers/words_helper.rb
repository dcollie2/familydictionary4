module WordsHelper

  def linkTerms(definition)
    linkedDefinition = definition #linkUpTerms(['a'],word.definition)
    # for each word in the system besides the current one
    # check the array of words in the current definition
    # if there's a match, link the matched definition word to the word
    Word.all.each do |word|
      linkedDefinition = linkUpTerms(word,linkedDefinition) unless word == 'A'
    end
    linkedDefinition
  end

  def linkUpTerms(word, definition)
    word.matches.each do |term|
      # Rails.logger.info term if find_words(definition).include?(term)
      definition = definition.gsub( /\b#{term}\b/i, '<a href="/words/' + word.word.downcase + '" class="termLink">\0</a>') if matches?(term,definition)
    end
    definition
  end

  def matches?(term, definition)
    find_words(definition).include?(term.downcase)
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

end

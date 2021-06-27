class Word < ApplicationRecord
  # has_rich_text :definition
  has_one_attached :audio

  has_many :child_citations, :class_name => "Citation", :foreign_key => :source_id, :dependent => :destroy
  has_many :defined_words, :through => :child_citations

  has_many :parent_citations, :class_name => "Citation", :foreign_key => :destination_id
  has_many :defining_words, :through => :parent_citations

  after_create :check_links
  # Restore conditions after import is complete
  after_update :check_links #, if: :definition_changed?

  after_create_commit {broadcast_prepend_to "words"}
  after_update_commit {broadcast_replace_to "words"}
  after_destroy_commit {broadcast_remove_to "words"}

  def word_for_slug
    word.downcase
  end

  extend FriendlyId
  friendly_id :word_for_slug, use: :slugged

  scope :by_created_at, -> { order(:created_at) }
  scope :current, -> { by_created_at.last }

  def first_letter
    word[0,1].downcase
  end

  def full_word
    if prefix.blank?
      "#{word}"
    else
      "#{prefix} #{word}"
    end
  end

  def next_by_date
    Word.where(["created_at > ? and id != ?", self.created_at, self.id]).limit(1).order(:created_at).first
  end
  def prior_by_date
    Word.where(["created_at < ? and id != ?", self.created_at, self.id]).limit(1).order("created_at DESC").first
  end
  def others
    Word.find(:all, :conditions => ["id != ?", id]).collect { |i| i.word }
  end

  def has_defined_words?
    child_citations.present?
  end

  def defined_elsewhere?
    !parent_citations.empty?
  end

  # For determining matches with other words

  def matches
    match = [word.downcase]
    match = match + also_matches.split(" ") unless also_matches.blank?
    match
  end

  # NEW STUFF
  # Get a definition's unique words
  def unique_words
    WordsCounted::Tokeniser.new(ActionController::Base.helpers.strip_tags(definition)).tokenise.uniq
  end

  scope :other_defined_words, ->(id) { where.not(id: id) }
  scope :with_also_matches, -> { where.not(also_matches: [nil,'']) }

  def other_words_downcased
    result = Word.other_defined_words(id).pluck(:word)
    if result.present?
      result.map!(&:downcase)
    else
      []
    end
  end

  def also_match_words
    result = Word.other_defined_words(id).with_also_matches&.pluck(:also_matches).flatten
  end

  def matched_words
    unique_words.intersection(other_words_downcased.concat(also_match_words))
  end

  def check_links
    # Clear all existing links to defined words
    # Save @word with links set in linked_definition
    child_citations.destroy_all
    if matched_words.present?
      puts "-------"
      puts "#{word}: #{matched_words}"
      matched_words.each do |match|
        puts "Citation: #{id} to #{match}"
        matched_word = Word.where(slug: match).first
        if matched_word.blank?
          matched_word = Word.where(":words = ANY (also_matches)", words: match).first
          puts("ALT MATCH on #{word}!!!") if matched_word.present?
        end
        unless matched_word.blank?
          # find or create because also_matches can contain duplicates
          child_citations.find_or_create_by!(:destination_id => matched_word.id)
          puts "Matching #{word} to #{matched_word.word}"
        else
          puts "NO MATCH FOUND!"
        end
      end
    else
      puts "#{word} has no matched words. #{matched_words} - #{definition}-------"
    end
    # Ok. Now do all the other words
    # Word.all.each { |word| word.save! }
  end
end

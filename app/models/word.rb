class Word < ApplicationRecord
  has_rich_text :definition
  has_one_attached :audio

  has_many :child_citations, :class_name => "Citation", :foreign_key => :source_id, :dependent => :destroy
  has_many :defined_words, :through => :child_citations

  has_many :parent_citations, :class_name => "Citation", :foreign_key => :destination_id
  has_many :defining_words, :through => :parent_citations

  after_create :check_links
  after_update :check_links #, if: :definition_changed?

  after_create_commit {broadcast_prepend_to "words"}
  after_update_commit {broadcast_replace_to "words"}
  after_destroy_commit {broadcast_remove_to "words"}

  extend FriendlyId
  friendly_id :word, use: :slugged

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
    WordsCounted::Tokeniser.new(ActionController::Base.helpers.strip_tags(definition.to_plain_text)).tokenise.uniq
  end

  scope :other_defined_words, ->(id) { where.not(id: id).pluck(:word) }

  def defined_words_downcased
    Word.other_defined_words(id).map!(&:downcase)
  end

  def matched_words
    unique_words.intersection(defined_words_downcased)
  end

  def check_links
    # Clear all existing links to defined words
    # Create new links based on current definition
    # Save @word with links set in linked_definition
    child_citations.destroy_all
    matched_words.each do |word|
      logger.debug("Citation: #{id} to #{word}")
      matched_word = Word.friendly.find(word)
      # Find or create probably redundant since we're going by distinct list of matches
      if matched_word.present?
        # else case could catch also_match once we incorporate those in matched_words
        child_citations.find_or_create_by!(:destination_id => matched_word.id)
      end
    end
    # Ok. Now do all the other words
    # Word.all.each { |word| word.save! }
  end
end

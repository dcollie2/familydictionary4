class Word < ApplicationRecord
  has_rich_text :definition
  has_one_attached :audio

  after_create_commit {broadcast_prepend_to "words"}
  after_update_commit {broadcast_replace_to "words"}
  after_destroy_commit {broadcast_remove_to "words"}

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
end

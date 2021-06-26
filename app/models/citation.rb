class Citation < ApplicationRecord
  belongs_to :defining_word, :class_name => "Word", :foreign_key => "source_id"
  belongs_to :defined_word, :class_name => "Word", :foreign_key => "destination_id"

  def source
    "#{defining_word.word}"
  end
  def target
    "#{defined_word.word}"
  end
  def value
    1
  end

end

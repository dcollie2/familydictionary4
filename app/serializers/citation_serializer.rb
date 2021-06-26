class CitationSerializer < ActiveModel::Serializer
  attributes :source, :target, :value
  # has_one :defined_word, embed: :ids, include: false
  def source
    "#{object.defining_word.word}"
  end
  def target
    "#{object.defined_word.word}"
  end
  def value
    1
  end
end

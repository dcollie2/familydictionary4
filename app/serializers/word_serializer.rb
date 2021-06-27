class WordSerializer < ActiveModel::Serializer
  attributes :id, :word, :definition #, :defines, :defined_by
  #has_many :child_citations, embed: :ids, include: true
  
  # has_many :defined_words
end

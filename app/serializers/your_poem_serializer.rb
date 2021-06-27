class YourPoemSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :comment
end

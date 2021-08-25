class Page < ApplicationRecord
  has_rich_text :contents

  extend FriendlyId
  friendly_id :permalink #, use: :slugged

  scope :navigable, -> { where("permalink in ('advice','lexicographer','ifaq','poetrymonth','map')") }

end

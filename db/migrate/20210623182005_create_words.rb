class CreateWords < ActiveRecord::Migration[6.1]
  def change
    create_table :words do |t|
      t.string :prefix
      t.string :word
      t.text :definition
      t.string :phonetic
      t.string :syllables
      t.string :slug
      t.text :also_matches, array: true, default: []

      t.timestamps
    end
  end
end

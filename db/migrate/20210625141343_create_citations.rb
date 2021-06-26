class CreateCitations < ActiveRecord::Migration[6.1]
  def change
    create_table :citations do |t|
      t.integer :source_id
      t.integer :destination_id

      t.timestamps
    end
  end
end

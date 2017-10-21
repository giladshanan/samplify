class CreateTracks < ActiveRecord::Migration[5.1]
  def change
    create_table :tracks do |t|
      t.string :name
      t.string :artist
      t.string :album
      t.string :preview_url
      t.string :image
      t.integer :sampler_id
      t.timestamps
    end
  end
end

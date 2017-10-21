class CreateSamplers < ActiveRecord::Migration[5.1]
  def change
    create_table :samplers do |t|
      t.string :title
      t.integer :user_id
      t.string :spotify_url
      t.timestamps
    end
  end
end

class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :display_name
      t.string :email
      t.string :spotify_id
      t.string :profile_pic_url

      t.timestamps
    end
  end
end

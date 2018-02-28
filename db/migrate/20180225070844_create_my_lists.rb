class CreateMyLists < ActiveRecord::Migration[5.1]
  def change
    create_table :my_lists do |t|
      t.integer :user_id
      t.string :video_id
      t.timestamps
    end
  end
end

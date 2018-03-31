class CreateMyLists < ActiveRecord::Migration[5.1]
  def change
    create_table :my_lists, options: 'ENGINE=InnoDB CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC' do |t|
      t.integer :user_id
      t.string :video_id
      t.timestamps
    end
  end
end

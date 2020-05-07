class CreateLikes < ActiveRecord::Migration[5.2]
  def change
    create_table :likes do |t|
      t.string :post_id
      t.string :user_id

      t.timestamps
    end
  end
end

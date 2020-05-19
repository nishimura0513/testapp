class AddClomnToPost < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :guser_id, :string
  end
end

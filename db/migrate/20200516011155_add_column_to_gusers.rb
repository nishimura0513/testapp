class AddColumnToGusers < ActiveRecord::Migration[5.2]
  def change
    add_column :gusers, :name, :string
    add_column :gusers, :provider, :string
    add_column :gusers, :uid, :string
    add_column :gusers, :token, :string
    add_column :gusers, :meta, :string
    add_column :gusers, :image_name, :string
  end
end

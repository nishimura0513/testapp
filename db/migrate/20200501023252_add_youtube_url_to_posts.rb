class AddYoutubeUrlToPosts < ActiveRecord::Migration[5.2]
  def change

    add_column :posts, :youtube_url, :string

  end
end

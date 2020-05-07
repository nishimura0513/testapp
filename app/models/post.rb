class Post < ApplicationRecord

  validates :content, {length: {maximum: 140}, presence:true}

  def user
    return User.find_by(id: self.user_id)
  end
  mount_uploader :image, ImageUploader
  mount_uploader :video, VideoUploader

  def self.search(search) #selfはPostモデルのこと
    if search
      self.where(["content LIKE ?","%#{search}%"]) #contentカラムのなかに変数searchとおなじものを取り出す。
    else
      self.all #なければ全て表示する
    end
  end


end

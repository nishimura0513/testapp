class User < ApplicationRecord
  has_secure_password
  validates :name,{presence: true, uniqueness: true}
  validates :email, {presence: true, uniqueness: true}

  def user
    return User.find_by(id: self.user_id)
  end

  def guser
    return Guser.find_by(id: self.guser_id)
  end


end

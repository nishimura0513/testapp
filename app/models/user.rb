class User < ApplicationRecord
  has_secure_password
  validates :name,{presence: true, uniqueness: true}
  validates :email, {presence: true, uniqueness: true}

  def user
    return User.find_by(user_id: self.id)
  end
  def guser
    return Guser.find_by(guser_id: self.id)
  end

end

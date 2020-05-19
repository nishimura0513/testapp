class Like < ApplicationRecord
  def user
    return User.find_by(id: self.user_id)
  end

  def post
    return Post.find_by(id: self.post_id)
  end

  def guser
    return Guser.find_by(id: self.user_id)
  end


  def post_user
    post =Post.find_by(id: self.post_id)
    if post != nil
       if User.find_by(id: post.user_id)
         return User.find_by(id: post.user_id)
       else
         return Guser.find_by(id: post.user_id)
       end
     end
  end

end

class LikesController < ApplicationController

before_action :no_login_user

  def create
    @like = Like.new(
      post_id: params[:id],
      user_id: @current_user.id
    )
    @like.save
    redirect_to("/")
  end

  def destroy
    @like = Like.find_by(
      post_id: params[:id],
      user_id: @current_user.id
    )
    @like.destroy
    redirect_to("/")

  end

  def profile
    @likes = Like.where(user_id: params[:id])
    @user =User.find_by(id: params[:id])
  end


end

class LikesController < ApplicationController

before_action :no_login_user

  def create
    @like = Like.new(
      post_id: params[:id],
      user_id: session[:user_id]
    )
    @like.save
    redirect_to("/")
  end

  def destroy
    @like = Like.find_by(
      post_id: params[:id],
      user_id: session[:user_id]
    )
    @like.destroy
    redirect_to("/")

  end

  def profile
    @likes = Like.where(user_id: like_params[:id])
    if User.find_by(id: like_params[:id])
      @user = User.find_by(id: like_params[:id])
    else
      @user = Guser.find_by(id: like_params[:id])
    end
  end

  private
    def like_params
      params.permit(:id)
    end
     #strong_params
end

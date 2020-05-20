class LikesController < ApplicationController

before_action :no_login_user

  def create
    if session[:user_id]
      @like = Like.new(
        post_id: params[:id],
        user_id: session[:user_id])
    else
      @like = Like.new(
        post_id: params[:id],
        guser_id: session[:guser_id])
    end
    @like.save
    redirect_to("/")
  end

  def destroy
    @like = Like.find_by(
      post_id: params[:id],
      user_id: session[:user_id],
      guser_id: session[:guser_id])
    @like.destroy
    redirect_to("/")

  end

  def profile
    if User.find_by(id: session[:user_id])
      @user = User.find_by(id: like_params[:id])
      @likes = Like.where(user_id: like_params[:id])
    else
      @user = Guser.find_by(id: like_params[:id])
      @likes = Like.where(guser_id: like_params[:id])
    end
  end



  private
    def like_params
      params.permit(:id)
    end
     #strong_params
end

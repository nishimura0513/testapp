class UsersController < ApplicationController

before_action :login_user,{only: [:signup,:signup_form,:new,:create]}
before_action :no_login_user, {only: [:signout, :edit, :update]}
before_action :ensure_correct_user, {only: [:edit, :update]}

  def signup_form
  end


  def signup
    @user = User.find_by(
      email: user_params[:email],
    )
    if @user && @user.authenticate(user_params[:password])
      session[:user_id] = @user.id
      redirect_to("/")
    else
      @error_messagae = "emailまたはpasswordが間違っています"
      render("users/signup_form")
    end
  end


  def signout
    session[:user_id] = nil
    flash[:notice] = "ログアウトしました"
    redirect_to("/")
  end

  def new
    @user =User.new
  end


  def create
    @user = User.new(
      name: user_params[:name],
      email: user_params[:email],
      password: user_params[:password],
      image_name: "default.jpg"
     )
    if @user.save
      session[:user_id]=@user.id
      flash[:notice]= "登録しました"
      redirect_to("/")
    else
      render("users/new")
    end
  end


  def profile
    @user = User.find_by(id: user_params[:id])
    @posts = Post.where(user_id: @user.id)
  end


  def edit
    @user = User.find_by(id: user_params[:id])
  end


  def update
    @user = User.find_by(id: user_params[:id])
    @user.name = user_params[:name]
    @user.email = user_params[:email]
    if user_params[:image]
      @user.image_name = "#{@user.id}.jpg"
      image = user_params[:image]
      File.binwrite("public/img-profiles/#{@user.image_name}",image.read)
    end
    if @user.save
      redirect_to("/users/#{@user.id}/profile")
    else
      flash[:notice] = "既にあるname、もしくはemailです"
      render("users/edit")
    end
  end


  def ensure_correct_user
    user = User.find_by(id: user_params[:id])
    if user.id != @current_user.id
      flash[:notice] = "ログインしているユーザー以外の編集はできません"
      redirect_to("/")
    end
  end
  #編集などをできるユーザーの制御


  private
    def user_params
      params.permit(:id,:name,:email,:password,:image, :image_name)

    end
     #strong_params

end

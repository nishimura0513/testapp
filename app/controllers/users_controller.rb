class UsersController < ApplicationController

before_action :login_user,{only: [:signup,:signup_form,:new,:create]}
before_action :no_login_user, {only: [:signout, :edit, :update]}
before_action :ensure_correct_user, {only: [:edit, :update]}

  def signup_form

  end
  def signup
    @user = User.find_by(
      email: params[:email],
    )
    if @user && @user.authenticate(params[:password])
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
      name: params[:name],
      email: params[:email],
      password: params[:password],
      image_name: "default"
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
    @user = User.find_by(id: params[:id])
    @posts = Post.where(user_id: @user.id)
  end

  def edit
    @user = User.find_by(id: params[:id])
  end
  def update
    @user = User.find_by(id: params[:id])
    @user.name = params[:name]
    @user.email = params[:email]

    if params[:image]
      @user.image_name = "#{@user.id}.jpg"
      image = params[:image]
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
    user = User.find_by(id: params[:id])
    if user.id != @current_user.id
      flash[:notice] = "ログインしているユーザー以外の編集はできません"
      redirect_to("/")
    end
  end
  #編集などをできるユーザーの制御

end

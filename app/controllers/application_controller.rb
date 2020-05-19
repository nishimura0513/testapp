class ApplicationController < ActionController::Base

  before_action :set_current_user

  def set_current_user
    if User.find_by(id: session[:user_id])
      @current_user = User.find_by(id: session[:user_id])
    else
      @current_user = Guser.find_by(id: session[:user_id])
    end
  end
  # set_current_userをbefore_action で定義することによってどこでも変数@current_userを使うことができる。

  def login_user
    if @current_user
      flash[:notice] = "ログインしています。"
      redirect_to("/")
    end
  end
  #ログインしているユーザーに対する制御

  def no_login_user
    if @current_user == nil
      flash[:notice] = "ログインしてください"
      redirect_to("/signup")
    end
  end
  #ログインしていないユーザーに対する制御



end

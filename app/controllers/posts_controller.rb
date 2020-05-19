class PostsController < ApplicationController

  before_action :no_login_user, {only: [:new, :create, :edit, :update, :destroy, ]}
  before_action :ensure_correct_user, {only: [:edit, :update, :destroy]}


  def top
    @posts = Post.all.order(created_at: :desc)
  end


  def image
    @post = Post.find_by(id: post_params[:id])
  end


  def new
    @post = Post.new
  end


  def create
    @post = Post.new(
      content: post_params[:content],
      user_id: session[:user_id],
      video: post_params[:video]
    )
    if @post.save
      flash[:notice] ="投稿しました"
      redirect_to("/")
    else
      render("posts/new")
    end
  end


  def show
    @post = Post.find_by(id: post_params[:id])
  end


  def edit
    @post = Post.find_by(id: post_params[:id])
  end


  def update
    @post = Post.find_by(id: post_params[:id])
    @post.content = post_params[:content]
    if params[:video]
      @post.video = post_params[:video]
    end
    if @post.save
      flash[:notice] ="変更できました。"
      redirect_to("/posts/#{@post.id}")
    else
      render("posts/edit")
    end
  end


  def destroy
    @post = Post.find_by(id: post_params[:id])
    @post.destroy
    flash[:notice] ="削除しました"
    redirect_to("/")
  end


  def search_form
    @posts =Post.search(params[:search])
    #searchはPOSTモデルで作ったメソッド
  end


  def ensure_correct_user
    post = Post.find_by(id: post_params[:id])
    if post.user_id != session[:user_id]
      flash[:notice] = "ログインしているユーザー以外の編集はできません"
      redirect_to("/")
    end
  end
  #編集などをできるユーザーの制御

  private
    def post_params
      params.permit(:id,:content,:video)
    end

     #strong_params

end

class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:new]
  before_action :find, only: [:show, :edit, :update, :destroy, :move_to_index]
  before_action :move_to_index, only: [:edit, :update, :destroy]
  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @comment = Comment.new
    @comments = @post.comments.includes(:user)
  end

  def edit
  end

  def update
    if @post.update(post_params)
      redirect_to post_path
    end
  end

  def destroy
    if @post.destroy
      redirect_to root_path
    else
      render :show
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :text, :image).merge(user_id: current_user.id)
  end

  def move_to_index
    if current_user.id != @post.user_id
      redirect_to action: :index
    end
  end

  def find
    @post = Post.find(params[:id])
  end

end

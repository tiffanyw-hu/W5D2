class PostsController < ApplicationController
  before_action :require_login, only: [:create, :new, :update, :edit, :destroy]

  def show
    @post = Post.find(params[:id])
  end

  def new
  end

  def create
    @post = Post.new(post_params)
    @post.author = current_user
    post_params[:sub_ids] << params[:sub_id]
    if @post.save
      redirect_to sub_url(@post.sub)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.author == current_user
      if @post.update(post_params)
        redirect_to sub_url(@post.sub)
      else
        flash.now[:errors] = @post.errors.full_messages
        render :edit
      end
    else
      flash.now[:errors] = ['That is not your post']
      render :edit
    end
  end


  def destroy
    @post = Post.find(params[:id])
    @post.destroy!
    redirect_to sub_url(@post.sub)
  end

  def post_params
    params.require(:post).permit(:title, :url, :content, sub_ids: [])
  end
end

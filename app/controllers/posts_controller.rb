class PostsController < ApplicationController

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.author_id = current_user.id
    if @post.save
      redirect_to post_url(@post)
    else
      fail
      flash.now[:errors] ||= []
      flash.now[:errors] << @post.errors.full_messages
      render :new
    end
  end

  def show
    @post = Post.find(params[:id])
    @all_comments = @post.comments.to_a 
    @top_comments = @post.comments.where(parent_comment_id: nil)
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    @post.author_id = current_user.id
    if @post.update_attributes(post_params)
      redirect_to post_url(@post)
    else
      flash.now[:errors] ||= []
      flash.now[:errors] << @post.errors.full_messages
      render :edit
    end
  end

  def destroy
    @post = Post.find(post_params[:id])
    @post.destroy
  end

  private

  def post_params
    params.require(:post).permit(:title, :url, :content, sub_ids: [])
  end
end

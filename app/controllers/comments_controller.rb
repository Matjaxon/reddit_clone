class CommentsController < ApplicationController

  before_action :enforce_login, except: [:index, :show]

  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.author_id = current_user.id
    @comment.post_id = params[:post_id]
    if @comment.save
      redirect_to post_url(@comment.post_id)
    else
      flash.now[:errors] ||= []
      flash.now[:errors] << @comment.errors.full_messages
      render :new
    end
  end

  def destroy
    @comment = Comment.find_by(params[:id])
    @comment.destroy
  end

  def edit
    @comment = Comment.find(params[:id])
  end

  def update
    @comment = Comment.find(params[:id])
    if @comment.update_attributes(comment_params)
      redirect_to post_url(@comment.post)
    else
      flash.now[:errors] ||= []
      flash.now[:errors] << @comment.errors.full_messages
      render :edit
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:content, :parent_comment_id)
  end

  def enforce_login
    unless current_user
      flash[:errors] ||= []
      flash[:errors] << "Must be logged in to post or edit a comment"
      redirect_to new_session_url
    end
  end
end

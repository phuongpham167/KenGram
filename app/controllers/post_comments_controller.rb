class PostCommentsController < ApplicationController
  before_action :logged_in_user, only: %i(create destroy update)
  before_action :correct_user, only: %i(destroy update)
  before_action :load_comment, only: %i(update destroy)

  def create
    @post_comment = current_user.post_comments.build post_comment_params
    if @post_comment.save
      flash[:success] = t "success"
      redirect_to request.referrer || root_url
    else
      flash[:danger] = t ".danger"
      redirect_to request.referrer
    end
  end

  def update
    if @post_comment.update_attributes post_comment_params
      flash[:success] = t ".success"
      redirect_to @post_comment.post
    else
      flash[:danger] = t ".danger"
      render :edit
    end
  end

  def destroy
    if @post_comment.destroy
      flash[:success] = t ".success"
    else
      flash[:danger] = t ".danger"
    end
    redirect_to request.referrer || root_url
  end

  private

    def post_comment_params
      params.require(:post_comment).permit :post_id, :user_id, :content
    end

    def correct_user
      @post_comment = current_user.post_comments.find_by id: params[:id]
      redirect_to root_url if @post_comment.nil?
    end

    def load_comment
      @post_comment = PostComment.find_by id: params[:id] || not_found
      return if @post_comment
      flash[:danger] = t ".danger"
      redirect_to root_url
    end
end

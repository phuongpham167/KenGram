class BookmarksController < ApplicationController
  before_action :logged_in_user

  def create
    post_id = Post.find_by id: params[:post_id]
    current_user.bookmark post_id
    redirect_to request.referrer
  end

  def destroy
    post_id = Bookmark.find_by(id: params[:id]).post_id
    current_user.unbookmark post_id
    redirect_to request.referrer
  end
end

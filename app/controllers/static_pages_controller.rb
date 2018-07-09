class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @post = current_user.posts.build
      @feed_items = Post.by_user(current_user.id).page(params[:page]).per(Settings.user.show.per_page)
    end
  end

end

class PostsController < ApplicationController
  before_action :load_post, only: %i(show edit update destroy)
  before_action :logged_in_user, only: %i(create destroy)

  def index;  end

  def new
    @post = Post.new
    @post_attachment = @post.post_attachments.build
  end

  def create
    @post = current_user.posts.build post_params
    if @post.save
      params[:post_attachments]["avatar"].each do |a|
          @post_attachment = @post.post_attachments.create!(:avatar => a, :post_id => @post.id)
      end
      flash[:success] = t ".success"
      redirect_to root_url
    else
      render "static_pages/about"
    end
  end

  def show;  end

  def edit;  end

  def update;  end

  def destroy;  end

  private
    def load_post
      @post = Post.find_by id: params[:id]
      return if @post
      flash[:danger] = t ".danger"
      redirect_to root_url
    end

    def post_params
      params.require(:post).permit :caption, post_attachments_attributes:
        [:id, :post_id, :avatar]
    end
end

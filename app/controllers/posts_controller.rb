class PostsController < ApplicationController
  before_action :load_post, only: %i(show edit update destroy)
  before_action :logged_in_user, only: %i(create destroy)

  def index
    @post = Post.search params[:find]
  end

  def new
    @post = Post.new
    @post_attachment = @post.post_attachments.build
  end

  def create
    @post = current_user.posts.build post_params
    if @post.save
      id = @post.id
      params[:post_attachments]["avatar"].each do |a|
        @post_attachment = @post.post_attachments.create! avatar: a, post_id: id
      end
      flash[:success] = t ".success"
      redirect_to root_url
    else
      render "static_pages/about"
    end
  end

  def show
    @post_attachments = @post.post_attachments.all
  end

  def edit;  end

  def update
    @post = Post.find_by id: params[:id]
    if @post.update_attributes post_params
      flash[:success] = t ".success"
      redirect_to root_url
    else
      render :edit
    end
  end

  def destroy
    if @post.destroy
      flash[:success] = t ".flash_sucess_destroy"
    else
      flash[:danger] = t ".flash_danger_destroy"
    end
    redirect_to request.referrer || root_url
  end

  def post_like
    @post = Post.find_by id: params[:id] || not_found
    render :show_like
  end

  private

  def load_post
    @post = Post.find_by id: params[:id] || not_found
    return if @post
    flash[:danger] = t ".danger"
    redirect_to root_url
  end

  def post_params
    params.require(:post).permit :caption, :tag, :album_id
  end

  def destroy
    if @post.destroy
      flash[:success] = t ".flash_sucess_destroy"
    else
      flash[:danger] = t ".flash_danger_destroy"
    end
    redirect_to request.referrer || root_url
  end
end

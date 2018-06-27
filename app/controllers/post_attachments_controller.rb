class PostAttachmentsController < ApplicationController
  before_action :load_post_attachment, only: %i(show edit update destroy)

  def index;  end

  def new
    @post_attachment = PostAttachment.new
  end

  def create;  end

  def show; end

  def edit; end

  def update;  end

  def destroy;  end

  private
    def load_post_attachment
      @post_attachment = PostAttachment.find_by id: params[:id]
      return if @post_attachment
      flash[:danger] = t ".danger"
      redirect_to root_url
    end

    def post_attachment_params
      params.require(:post_attachment).permit :post_id, :avatar
    end
end

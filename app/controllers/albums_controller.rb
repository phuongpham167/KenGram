class AlbumsController < ApplicationController
  def new
    @album = Album.new
  end
  def create
    @album = current_user.albums.build(album_params)
    if @album.save
      flash[:success] = t ".success"
      redirect_to root_url
    else
      flash[:danger] = t ".danger"
      redirect_to root_url
    end
  end

  def show
    @album = Album.find_by id: params[:id]
  end

  private
    def album_params
      params.require(:album).permit(:name, :caption)
    end
end

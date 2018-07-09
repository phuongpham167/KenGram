class AlbumsController < ApplicationController
  def new
    @album = Album.new
  end

  def create
    @album = current_user.albums.build(album_params)
    if @album.save
      flash[:success] = t ".success"
    else
      flash[:danger] = t ".danger"
    end
    redirect_to root_url
  end

  def show
    @album = Album.find_by id: params[:id] || not_found
  end

  private
  def album_params
    params.require(:album).permit :name, :caption
  end
end

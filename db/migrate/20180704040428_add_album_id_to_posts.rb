class AddAlbumIdToPosts < ActiveRecord::Migration[5.1]
  def change
    add_column :posts, :album_id, :integer
  end
end

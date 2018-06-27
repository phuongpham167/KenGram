class AddTagToPosts < ActiveRecord::Migration[5.1]
  def change
    add_column :posts, :tag, :string
  end
end

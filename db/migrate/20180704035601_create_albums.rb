class CreateAlbums < ActiveRecord::Migration[5.1]
  def change
    create_table :albums do |t|
      t.references :user, foreign_key: true
      t.string :name
      t.string :caption

      t.timestamps
    end
  end
end

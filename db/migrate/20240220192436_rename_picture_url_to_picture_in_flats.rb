class RenamePictureUrlToPictureInFlats < ActiveRecord::Migration[7.1]
  def change
    rename_column :flats, :picture_url, :picture
  end
end

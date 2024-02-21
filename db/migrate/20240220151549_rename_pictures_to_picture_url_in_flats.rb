class RenamePicturesToPictureUrlInFlats < ActiveRecord::Migration[7.1]
  def change
    rename_column :flats, :pictures, :picture_url
  end
end

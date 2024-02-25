class AddDescriptionToFlats < ActiveRecord::Migration[7.1]
  def change
    add_column :flats, :description, :text
  end
end

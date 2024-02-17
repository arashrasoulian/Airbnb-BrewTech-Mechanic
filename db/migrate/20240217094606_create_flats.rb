class CreateFlats < ActiveRecord::Migration[7.1]
  def change
    create_table :flats do |t|
      t.string :name
      t.decimal :price
      t.text :pictures
      t.references :user, null: false, foreign_key: true
      t.text :address

      t.timestamps
    end
  end
end

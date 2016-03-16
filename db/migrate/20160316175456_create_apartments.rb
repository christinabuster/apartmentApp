class CreateApartments < ActiveRecord::Migration
  def change
    create_table :apartments do |t|
      t.string :address
      t.string :name
      t.string :contact
      t.float :longitude
      t.float :latitude

      t.timestamps null: false
    end
  end
end

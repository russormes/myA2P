class CreatePupils < ActiveRecord::Migration
  def change
    create_table :pupils do |t|
      t.string :given_name
      t.string :other_name
      t.string :family_name
      t.string :name_known_by
      t.date :dob
      t.integer :gender
      t.string :image_path

      t.timestamps
    end
  end
end

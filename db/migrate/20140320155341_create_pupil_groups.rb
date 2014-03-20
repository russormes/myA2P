class CreatePupilGroups < ActiveRecord::Migration
  def change
    create_table :pupil_groups do |t|
      t.references :pupil, index: true
      t.references :group, index: true

      t.timestamps
    end
  end
end

class AddIndexToNameFieldInPupils < ActiveRecord::Migration
  def change
    add_index :pupils, :family_name
  end
end

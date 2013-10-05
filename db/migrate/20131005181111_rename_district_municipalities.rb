class RenameDistrictMunicipalities < ActiveRecord::Migration
  def up
    rename_column :districts, :municipalities, :municipality_no
  end

  def down
    rename_column :districts, :municipality_no, :municipalities
  end
end

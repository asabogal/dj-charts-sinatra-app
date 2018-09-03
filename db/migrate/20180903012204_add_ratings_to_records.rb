class AddRatingsToRecords < ActiveRecord::Migration
  def change
    add_column :records, :rating, :integer
  end
end

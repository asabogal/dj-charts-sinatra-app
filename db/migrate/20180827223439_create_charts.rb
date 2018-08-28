class CreateCharts < ActiveRecord::Migration
  def change
    create_table :charts do |t|
      t.string :name
      t.string :created_on
      t.integer :user_id
    end
  end
end

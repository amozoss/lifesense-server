class CreateTimeRecords < ActiveRecord::Migration
  def change
    create_table :time_records do |t|
      t.datetime :start
      t.datetime :end
      t.text :description
      t.integer :project_id

      t.timestamps
    end
    add_index :time_records, [:project_id, :start]
  end
end

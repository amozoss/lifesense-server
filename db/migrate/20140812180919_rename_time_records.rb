class RenameTimeRecords < ActiveRecord::Migration
  def change
    rename_column :time_records, :start, :started_at
    rename_column :time_records, :end, :ended_at

  end
end

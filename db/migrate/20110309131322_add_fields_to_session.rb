class AddFieldsToSession < ActiveRecord::Migration
  def self.up
    create_table :sessions
    add_column :sessions, :start_time, :datetime
    add_column :sessions, :end_time, :datetime
    add_column :sessions, :venue_id, :integer
  end

  def self.down
    drop_table :sessions
  end
end

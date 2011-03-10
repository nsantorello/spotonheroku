class AddSessionToVenue < ActiveRecord::Migration
  def self.up
  	add_column :venues, :session_id, :integer
  end

  def self.down
    remove_column :venues, :session_id
  end
end

class CreateVenues < ActiveRecord::Migration
  def self.up
    create_table :venues do |t|
      t.string :name
      t.string :description
	  
      t.timestamps
    end
    add_column :venues, :foursquare_id, :string
  end

  def self.down
    drop_table :venues
  end
end

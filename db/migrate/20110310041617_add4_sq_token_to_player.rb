class Add4SqTokenToPlayer < ActiveRecord::Migration
  def self.up
  	add_column :players, :foursquare_access_token, :string
  end

  def self.down
    remove_column :players, :foursquare_access_token
  end
end

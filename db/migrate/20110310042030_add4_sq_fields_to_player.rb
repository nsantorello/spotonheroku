class Add4SqFieldsToPlayer < ActiveRecord::Migration
  def self.up
  	remove_column :players, :name
  	add_column :players, :first_name, :string
  	add_column :players, :last_name, :string
  	add_column :players, :photo, :string
  end

  def self.down
  	add_column :players, :name, :string
  	remove_column :players, :first_name
  	remove_column :players, :last_name
  	remove_column :players, :photo
  end
end

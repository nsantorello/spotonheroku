class AddTreatsToPlayer < ActiveRecord::Migration
  def self.up
  	add_column :players, :treats, :integer, :default => 0
  end

  def self.down
    remove_column :players, :treats
  end
end

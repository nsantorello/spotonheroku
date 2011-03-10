class CreateCategoryRelations < ActiveRecord::Migration
  def self.up
    create_table :category_relations do |t|
	  t.string :our_tag
	  t.string :fsq_tag
      t.timestamps
    end
  end

  def self.down
    drop_table :category_relations
  end
end

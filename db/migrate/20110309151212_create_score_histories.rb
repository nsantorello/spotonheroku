class CreateScoreHistories < ActiveRecord::Migration
  def self.up
    create_table :score_histories do |t|
	  t.integer :player_id
  	  t.integer :venue_id
  	  t.integer :score, :default => 0
  	  t.date    :date
      t.timestamps
    end
  end

  def self.down
    drop_table :score_histories
  end
end

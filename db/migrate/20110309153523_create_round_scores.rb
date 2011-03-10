class CreateRoundScores < ActiveRecord::Migration
  def self.up
    create_table :round_scores do |t|
      t.integer :player_id
      t.integer :session_id
      t.integer :score
      t.timestamps
    end
  end

  def self.down
    drop_table :round_scores
  end
end

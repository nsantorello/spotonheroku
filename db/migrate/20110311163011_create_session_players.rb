class CreateSessionPlayers < ActiveRecord::Migration
  def self.up
    create_table :session_players do |t|
	  t.integer :player_id
	  t.integer :session_id
      t.timestamps
    end
  end

  def self.down
    drop_table :session_players
  end
end

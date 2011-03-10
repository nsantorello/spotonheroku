class CreateVenueQuestionRelations < ActiveRecord::Migration
  def self.up
    create_table :venue_question_relations do |t|
      t.integer :venue_id
      t.integer :question_id

      t.timestamps
    end
  end

  def self.down
    drop_table :venue_question_relations
  end
end

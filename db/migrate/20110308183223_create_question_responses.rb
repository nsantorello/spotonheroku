class CreateQuestionResponses < ActiveRecord::Migration
  def self.up
    create_table :question_responses do |t|
      t.string :text
      t.integer :question_id

      t.timestamps
    end
  end

  def self.down
    drop_table :question_responses
  end
end

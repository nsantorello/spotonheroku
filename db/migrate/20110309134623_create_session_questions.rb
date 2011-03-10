class CreateSessionQuestions < ActiveRecord::Migration
  def self.up
    create_table :session_questions do |t|
	  t.integer :session_id
	  t.integer :question_id
	  
      t.timestamps
    end
  end

  def self.down
    drop_table :session_questions
  end
end

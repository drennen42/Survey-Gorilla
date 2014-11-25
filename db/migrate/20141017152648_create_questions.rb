class CreateQuestions < ActiveRecord::Migration
  def change
  	create_table :questions do |t|
  		t.string :text
  		t.string :question_type
  		t.belongs_to :survey
  		t.timestamps
  	end
  end
end

class CreateAnswers < ActiveRecord::Migration
  def change
  	create_table :answers do |t|
  		t.belongs_to :choice
  		t.belongs_to :respondent
  		t.timestamps
  	end
  end
end

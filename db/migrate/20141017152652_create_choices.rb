class CreateChoices < ActiveRecord::Migration
  def change
  	create_table :choices do |t|
  		t.belongs_to :question
  		t.string :text
  		t.timestamps
  	end
  end
end

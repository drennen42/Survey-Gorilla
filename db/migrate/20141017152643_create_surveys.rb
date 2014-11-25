class CreateSurveys < ActiveRecord::Migration
  def change
  	create_table :surveys do |t|
  		t.string :name
      t.string :url
  		t.belongs_to :creator
  		t.timestamps
  	end
  end
end

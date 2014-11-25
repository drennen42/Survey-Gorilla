class CreateCreators < ActiveRecord::Migration
  def change
  	create_table :creators do |t|
  		t.string :username
  		t.string :password_hash
  		t.timestamps
  	end
  end
end

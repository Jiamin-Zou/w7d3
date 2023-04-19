class CreateGoals < ActiveRecord::Migration[7.0]
  def change
    create_table :goals do |t|
      t.bigint :user_id, null: false  
      t.string :name, null: false 

      t.timestamps
    end
  end
end

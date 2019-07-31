class CreateParticipations < ActiveRecord::Migration[5.2]
  def change
    create_table :participations do |t|
      t.integer :user_id
      t.integer :project_id
      t.integer :role

      t.timestamps
    end
  end
end

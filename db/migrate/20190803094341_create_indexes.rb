class CreateIndexes < ActiveRecord::Migration[5.2]
  def change
    add_index :participations, [:project_id, :user_id]
    add_index :participations, :role, name: "index_projects_admins", where: "(role = #{Participation.roles[:admin]})"
  end
end

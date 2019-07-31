class Project < ApplicationRecord
  has_and_belongs_to_many :participants, join_table: :participations, class_name: 'User'

  def admins
    participants_relation(:admin)
  end

  def users
    participants_relation(:user)
  end

  private

  def participants_relation(role)
    participants.where('participations.role = ?', Participation.roles[role])
  end
end

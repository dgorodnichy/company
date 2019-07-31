class Participation < ApplicationRecord
  belongs_to :project
  belongs_to :user

  enum role: { user: 0, admin: 1 }
end

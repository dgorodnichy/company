class User < ApplicationRecord
  has_and_belongs_to_many :projects, join_table: :participations
end

class College < ApplicationRecord
  has_many :exams
  # TODO: add this once it becomes necessary
  # has_many :users, through: :exams
end

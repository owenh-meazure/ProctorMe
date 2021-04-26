class Exam < ApplicationRecord
  has_many :users
  belongs_to :college
end

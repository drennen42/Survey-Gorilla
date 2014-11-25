class Survey < ActiveRecord::Base
  validates :url, uniqueness: true
	belongs_to :creator
  has_many :questions
	has_many :choices, through: :questions
end

class Question < ActiveRecord::Base
	belongs_to :survey
  has_many :choices
  has_many :answers, through: :choices
  has_many :respondents, through: :answers
end

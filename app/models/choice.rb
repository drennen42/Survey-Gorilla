class Choice < ActiveRecord::Base
  belongs_to :question
  has_many :answers
  has_many :respondents, through: :answers
end

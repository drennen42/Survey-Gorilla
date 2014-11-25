Creator.delete_all
Survey.delete_all
Question.delete_all
Choice.delete_all
Answer.delete_all
Respondent.delete_all

def url_generator
  alpha = ('a'..'z').to_a
  alpha_cap = ('A'..'Z').to_a
  chars = alpha + alpha_cap
  string = "/"
  15.times do
    string << chars.sample
  end
  string
end

5.times do
  creator = Creator.create!(username: Faker::Internet.user_name,
                            password: 'password')
  3.times do
    survey = creator.surveys.create!(name: Faker::Company.catch_phrase, url: url_generator)
    10.times do
      question = survey.questions.create!(text: Faker::Company.bs + "?",
                                          question_type: "multiple-choice")
      question.choices.create!(text: "Yes")
      question.choices.create!(text: "No")
      question.choices.create!(text: "Maybe")
    end
  end
end

2.times do
  respondent = Respondent.create!
  Survey.first.questions.each do |question|
    respondent.answers.create!(choice: question.choices.sample)
  end
end

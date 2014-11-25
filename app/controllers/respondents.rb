get '/respondents/:survey_id' do
  if session[:user_id] != nil
    @user = Creator.find(session[:user_id])
  end
  @survey = Survey.find(params[:survey_id])
  erb :'respondents/show'
end

post '/respondents/:survey_id/submit' do
  @survey = Survey.find(params[:survey_id])
  respondent = Respondent.create!
  params.each do |question_id, answer|
    question = Question.find_by(id: question_id)
    if question
      choice = question.choices.find_by_text(answer)
      choice.answers.create!(respondent: respondent)
    end
  end
  erb :'surveys/completed'
end

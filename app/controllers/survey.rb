before '/surveys/*' do
  if !session[:user_id]
    @message = "You must log in to view this page!"
    # erb :index
    redirect '/'
  end
end

get '/surveys/new' do
  @user = Creator.find(session[:user_id])
  @survey = Survey.new
  erb :'surveys/new'
end

get '/surveys/:survey_id' do
  if session[:user_id] != nil
    @user = Creator.find(session[:user_id])
  end
  @survey = Survey.find(params[:survey_id])
  erb :'surveys/show'
end

get '/surveys/:survey_id/show_results' do
  @user = Creator.find(session[:user_id])
  @survey = @user.surveys.find(params[:survey_id])
  erb :'surveys/show_results'
end

get '/survey' do
  @survey = Survey.new
  erb :'surveys/new'
end

post '/survey' do
  @creator = Creator.find(session[:user_id])
  @survey = Survey.find_or_create_by(name: params[:survey_title])
  @creator.surveys << @survey unless !@creator.surveys.where(id: @survey.id).empty?
  @question = Question.create!(text: params[:question_title])
  @survey.url = url_generator unless @survey.url
  @survey.save
  @survey.questions << @question
  create_choices(@question, params[:question])
  erb :'questions/_show', layout: false
end

get '/surveys/:survey_id/edit' do
  @survey = Survey.find(params[:survey_id])
  erb :'surveys/_edit_title', layout: false
end

post '/surveys/:survey_id/edit' do
  @survey = Survey.find(params[:survey_id])
  @survey.name = params[:survey_title]
  @survey.save 
  erb :'surveys/_show_title', layout: false
end

get '/surveys/:survey_id/:question_id' do
 @question = Question.find(params[:question_id])
 erb :"questions/_stats"
end

get "/surveys/:survey_id/questions/:question_id/delete" do
  @question = Question.find(params[:question_id])
  @question.destroy
  erb :'questions/_delete', layout: false
end

get "/surveys/:survey_id/questions/:question_id/edit" do
  @question = Question.find(params[:question_id])
  erb :'questions/_edit', layout: false
end

post "/surveys/:survey_id/questions/:question_id/edited" do
  @question = Question.find(params[:question_id])
  @question.text = params[:question_title]
  update_choices(@question, params[:update])
  @question.save
  erb :'questions/_show', layout: false
end

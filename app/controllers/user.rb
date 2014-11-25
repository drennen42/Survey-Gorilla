# before '/users/*' do
#   if !session[:user_id]
#     @message = "You must log in to view this page!"
#     erb :index
#   end
# end

get '/users/signout' do
  session[:user_id] = nil
  redirect "/"
end

get '/users/new' do
	erb :'users/new'
end

post '/users' do
	@user = Creator.find_by_username(params[:user][:username])
  if @user
    @message = "User already exists!"
    erb :'users/new'
  else
    @user = Creator.create!(params[:user])
    session[:user_id] = @user.id
    redirect "/users/#{@user.id}"
  end
end

post '/users/signin' do
  puts params[:user][:username]
  @user = Creator.find_by(username: params[:user][:username])
  if @user && @user.authenticate(params[:user][:password])
    session[:user_id] = @user.id
  	redirect "/users/#{@user.id}"
  else
    @message = "Incorrect username or password!"
    erb :'users/signin'
  end
end

get '/users/:user_id' do
  @user = Creator.find_by(id: session[:user_id])
  if !@user || @user.id.to_s != params[:user_id]
    # redirect "/users/#{session[:user_id]}"
    redirect '/'
  end
  erb :'users/show'
end

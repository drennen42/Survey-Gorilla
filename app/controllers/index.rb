get '/' do
	if session[:user_id]
		@user = Creator.find(session[:user_id])
		redirect "/users/#{@user.id}"
	end
	erb :index
end

get '/signin' do
	erb :'users/signin'
end

get '/signout' do
	session.delete(:user_id)
	redirect '/'
end



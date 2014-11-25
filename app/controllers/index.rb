get '/' do
	erb :index
end

get '/signin' do
	erb :'users/signin'
end

get '/signout' do
	session.delete(:user_id)
	redirect '/'
end



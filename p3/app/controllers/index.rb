get '/' do
  if current_user
    @users = User.all
    erb :index
  else
    redirect '/sessions/new'
  end
end

#----------- SESSIONS -----------

get '/sessions/new' do
  erb :sign_in
end

post '/sessions' do
  this_user = User.find_by(email: params[:email])
  p params[:email]
  if this_user = User.where(email: params[:email]).first
    session[:id] = this_user.id
    redirect '/'
  else
    "Wrong password"
  end
end

delete '/sessions/:id' do
  session.clear
  redirect '/'
end

#----------- USERS -----------

get '/users/new' do
  if current_user
    redirect '/'
  else
     erb :sign_up
  end
end

post '/users' do
  new_user = User.create(
    name: params[:name],
    email: params[:email],
    password: params[:password]
    )
  redirect '/'
end

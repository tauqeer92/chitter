require 'sinatra'
require "sinatra/reloader"
require_relative 'lib/database_connection'
require_relative 'lib/user_repository'
require_relative 'lib/peep_repository'


DatabaseConnection.connect('chitter')

class Application < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
    also_reload 'lib/user_repository'
    also_reload 'lib/peep_repository'
  
  get '/' do
    return erb(:create_user_form)
  end

  get '/users' do
    repo = UserRepository.new
    @users = repo.all
    return erb(:users)
  end

  post '/users' do
    repo = UserRepository.new
    user = User.new
    @user = params[:name]
    user.name = @user
    user.email = params[:email]
    user.password = params[:password]
    repo.create(user)
    
    redirect '/peeps'
  end

  get '/message_form' do
    return erb(:message_form)
  end

  get '/peeps' do
    repo = PeepRepository.new
    @peeps = repo.all
    return erb(:peeps)
  end

  post '/peeps' do
    repo = PeepRepository.new
    peep = Peep.new
    peep.subject = params[:subject]
    peep.content = params[:content]
    peep.user_id = params[:user_id]
    @time = Time.now
    peep.time = @time
    repo.create(peep)
    @peeps = repo.all
    return erb(:peeps)
  end

  get '/signup' do
    return erb(:create_user_form)
  end

  get '/login' do
    return erb(:login)
  end

  post '/login' do
    login
    redirect '/peeps'
  end

  def login
    repo = UserRepository.new
    all = repo.all
    all.each do |user|
      if user.email == params[:email]
        if user.password != params[:password]
            return 'Incorrect Password!'
        end
      elsif user.email != params[:email]
        return erb(:create_user_form) 
      else
        return erb(:message_form)
      end
    end 
  end
end
end
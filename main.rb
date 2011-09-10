require 'sinatra'
require 'haml'
require 'mongo_mapper'
require 'cgi'

configure do
  MongoMapper.connection = Mongo::Connection.new('localhost')
  MongoMapper.database   = 'playitsafe'
end

get '/startup' do 
  haml :startup
end

post '/startup' do
  begin
    user             = User.new
    user.sessionid   = params[:ID]
    user.name        = params[:PlayerName]
    user.age         = params[:PlayerAge]
    user.postcode    = params[:PostCode]
    user.gender      = params[:PlayerGender]
    user.ohstraining = params[:PreviousOHSTraining]
    user.playsgames  = params[:PlaysComputerGames]
    user.save
    'OK'
  rescue
    'Fail'
  end
end

get '/additional' do
  haml :additional
end

post '/additional' do
  begin
    user             = User.first(:sessionid => params[:ID])
    user.timeskilled = params[:TimesDied]
    user.playtime    = params[:PlayTime]
    user.completed   = params[:Completed]
    user.save
    'OK'
  rescue
    'Fail'
  end
end

get '/survey' do
  haml :survey
end

post '/survey' do
  #DB[:survey].insert CGI.parse request.body.string
end

get '/report' do
  #DB[:user]
end


class User
  include MongoMapper::Document
  key :sessionid,   String
  key :name,        String
  key :age,         String
  key :postcode,    String
  key :gender,      String
  key :ohstraining, String
  key :playsgames,  String
  key :timeskilled, String
  key :playtime,    String
  key :completed,   String
end

class Survey
  include MongoMapper::Document
  key :user_id,     String
  key :question1,   String
  key :question2,   String
  key :question3,   String
  key :question4,   String
  key :question5,   String
  key :question6,   String
  key :question7,   String
  key :question8,   String
  key :question9,   String
  key :question10,  String
  key :question11,  String
  key :question12,  String
end

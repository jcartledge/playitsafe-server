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
  begin
    user = User.first(:sessionid => params[:ID])
    user.survey = Survey.new
    user.survey.question1  = params[:Q1]
    user.survey.question2  = params[:Q2]
    user.survey.question3  = params[:Q3]
    user.survey.question4  = params[:Q4]
    user.survey.question5  = params[:Q5]
    user.survey.question6  = params[:Q6]
    user.survey.question7  = params[:Q7]
    user.survey.question8  = params[:Q8]
    user.survey.question9  = params[:Q9]
    user.survey.question10 = params[:Q10]
    user.survey.question11 = params[:Q11]
    user.survey.question12 = params[:Q12]
    user.save
    "OK"
  rescue
    "Fail"
  end
end

get '/report' do
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
  one :survey
end

class Survey
  include MongoMapper::EmbeddedDocument
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

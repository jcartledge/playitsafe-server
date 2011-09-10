require './main'     
require 'bowtie'

map '/admin' do
  run Bowtie::Admin
end

map '/' do
  run Sinatra::Application
end

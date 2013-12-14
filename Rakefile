require 'rake'
require 'sinatra'
require './the_app.rb'

desc 'run the server'
# so we don't have to run thin if we don't want to
task :run do |t|
  require './the_app.rb'
  TheApp.run!
end


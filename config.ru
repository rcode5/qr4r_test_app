require 'rubygems'
require 'sinatra'

disable :run, :reload

require './the_app.rb'

run TheApp.new

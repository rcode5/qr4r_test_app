require 'rubygems'
require 'sinatra'
require 'slim'

disable :run, :reload

require './the_app.rb'

run TheApp.new

require 'rubygems'
require 'bundler'
Bundler.require :default

require 'sinatra/base'

require 'slim'
require 'fileutils'

require 'qr4r'

class TheApp < Sinatra::Base

  set :environment, :production
  set :logging, true
  set :static, true
  set :root, Dir.pwd
  set :public_folder, File.join(settings.root, 'public')
  set :qrdir, File.join(settings.public_folder, 'generated')
  set :port, 5678
  APP_ROOT = root

  if !File.exists?(settings.qrdir)
    FileUtils::mkdir_p settings.qrdir
  end

  get '/' do
    slim :index
  end

  post '/' do
    link = params['encodeme']
    border = params['border']
    pixel_size = params['pixel_size'] || 20

    file = Tempfile.new(['qrcode', '.png'], settings.qrdir)

    encode_opts = {
      pixel_size: pixel_size,
      border: border
    }
    Qr4r::encode link, file.path, encode_opts
    slim :index, :locals => {
      file: asset_path(file.path),
      link: link
    }.merge(encode_opts)

  end

  run! if app_file == $0

  def asset_path(f)
    f.gsub(/^#{settings.public_folder}/, '')
  end
end

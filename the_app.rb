require 'sinatra'
require 'slim'

require 'qr4r'

class TheApp < Sinatra::Base
  set :environment, :production
  set :logging, true
  set :root, Dir.pwd
  set :public_folder, File.join(settings.root, 'public')
  set :qrdir, File.join(settings.public_folder, 'generated')
  set :port, 5678
  APP_ROOT = root

  get '/' do
    slim :index
  end

  post '/' do
    link = params['encodeme']
    file = Tempfile.new(['qrcode', '.png'], settings.qrdir, 'w')
    Qr4r::encode link, file.path, pixel_size: 20, border: 40
    
    slim :index, :locals => {:file => asset_path(file.path) }
  end

  run! if app_file == $0

  def asset_path(f)
    f.gsub(/^#{settings.public_folder}/, '')
  end
end
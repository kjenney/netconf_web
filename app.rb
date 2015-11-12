require "./models/device"
require "./models/netssh"

class App < Sinatra::Base
  enable :sessions
  register Sinatra::Flash 
  register Sinatra::Partial
  use Rack::MethodOverride
 
  get "/" do
   redirect "/devices"
  end

  get "/devices" do
    @devices = Device.all
    haml :"devices/index"
  end

  get "/devices/new" do
    @device = Device.new
    haml :"devices/new"
  end

  get "/devices/:id/edit" do
    @device = Device.find params[:id]
    haml :"devices/edit"
  end

  put "/devices/:id" do
    @device = Device.find params[:id]
    if @device.update_attributes params[:device]
      @device.update_attributes :updated => Time.now.strftime("%m/%d/%Y %H:%M") 
      redirect "/"
    end 
  end

  post "/devices" do
    @device = Device.new params[:device]
    if @device.save
      redirect "/"
    end
  end

  get "/devices/:id/update_data" do 
    @device = Device.find(params[:id])
    @device.update_attributes :serial => DeviceFetch.new.get_serial(params[:ip])
    if @device.update_attributes :model => DeviceFetch.new.get_model(params[:ip])
      @device.update_attributes :updated => Time.now.strftime("%m/%d/%Y %H:%M")
      redirect "/"
    end
  end
    

end


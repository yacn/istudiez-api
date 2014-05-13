require 'sinatra'
require 'json'

helpers do
  def json_status(code, reason)
    status code
    {status: code, reason: reason}.to_json
  end
end

get '/assignments', provides: :json do
  content_type :json
  if params[:all]
    json_status 200, 'Lists all assignments'
  else
    json_status 200, 'Lists active assignments'
  end
end

get '/assignments/:id', provides: :json do
  content_type :json
  json_status 200, 'Displays assignment with id ' + params[:id]
end

post '/assignments', provides: :json do
  content_type :json
  if request.media_type == 'application/json'
    begin
      request.body.rewind # in case somebody already read it
      data = JSON.parse request.body.read
      json_status 200, 'You sent me some JSON!'
    rescue JSON::ParserError => e
      json_status 400, 'Invalid JSON sent!'
    end
  else
    json_status 400, 'No JSON sent'
  end
end

put '/assignments/:id', provides: :json do
  content_type :json
  json_status 200, 'Update assignment with id ' + params[:id]
end

delete '/assignments/:id', provides: :json do
  content_type :json
  json_status 200, 'Delete assignment with id ' + params[:id]
end

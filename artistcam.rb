require 'sinatra'

sessionIds = Hash.new()

get '/sessionID/:artistURI' do
    if !sessionIds[params[:artistURI]]
        sessionIds[params[:artistURI]] = create_session()
    end
    sessionIds[params[:artistURI]].to_s
end

get '/token/:sessionID' do
    generate_token(params[:sessionID])
end

# Opentok

def create_session()
    "14685d1ac5907f4a2814fed28294d3f797f34955"
end

def generate_token(sessionID)
    "devtoken"
end
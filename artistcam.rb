require 'sinatra'
require 'opentok'

sessionIds = Hash.new()
trackUserIsListeningTo = Hash.new("Not available")

get '/:artistURI/session' do
    while sessionIds[params[:artistURI]+"_lock"]
        sleep 0.1
    end
    
    if !sessionIds[params[:artistURI]]
        sessionIds[params[:artistURI]+"_lock"] = "yay"
        sessionIds[params[:artistURI]] = create_session()
        sessionIds[params[:artistURI]+"_lock"] = false
    end
    sessionIds[params[:artistURI]].to_s
end

get '/:sessionID/token' do
    generate_token(params[:sessionID])
end

get '/:userID/track' do
    trackUserIsListeningTo[params[:userID]]
end

put '/:userID/track/:trackID' do
    trackUserIsListeningTo[params[:userID]] = params[:trackID]
end

# Opentok

def create_session()
    opentok = OpenTok::OpenTokSDK.new ENV['OPENTOK_KEY'], ENV['OPENTOK_SECRET']
    session = opentok.create_session "127.0.0.1"
end

def generate_token(sessionID)
    opentok = OpenTok::OpenTokSDK.new ENV['OPENTOK_KEY'], ENV['OPENTOK_SECRET']
    token = opentok.generate_token :session_id => @session
end
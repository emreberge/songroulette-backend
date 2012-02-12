require 'sinatra'
require 'opentok'

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
    opentok = OpenTok::OpenTokSDK.new ENV['OPENTOK_KEY'], ENV['OPENTOK_SECRET']
    session = opentok.create_session "127.0.0.1"
end

def generate_token(sessionID)
    opentok = OpenTok::OpenTokSDK.new ENV['OPENTOK_KEY'], ENV['OPENTOK_SECRET']
    token = opentok.generate_token :session_id => @session
end
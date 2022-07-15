require 'json'

class TweetsController < ApplicationController
  def create
    photo = current_user.photos.find(params[:photo_id])

    post_tweet(session[:my_tweet_app_token], photo.filename, url_for(photo))

    redirect_to photos_path
  end

  private def post_tweet(token, title, url)
    uri = URI('https://arcane-ravine-29792.herokuapp.com/api/tweets')
    body = {
      text: title,
      url: url,
    }

    req = Net::HTTP::Post.new(uri)
    req['Content-Type'] = 'application/json'
    req['Authorization'] = 'Bearer ' + token
    req.body = body.to_json

    http = Net::HTTP.new(uri.host, uri.port)

    http.use_ssl = true
    res = http.request(req)

    res.code === '201'
  end
end

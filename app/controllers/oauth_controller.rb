require 'net/http'

class OauthController < ApplicationController
  skip_before_action :authenticate_user

  def callback
    grant_code = params[:code]

    if grant_code.present?
      token = request_token(grant_code)
      session[:my_tweet_app_token] = token

      redirect_to photos_path
    else
      redirect_to photos_path
    end
  end

  private def request_token(code)
    uri = URI('https://arcane-ravine-29792.herokuapp.com/oauth/token')
    params = {
      'grant_type': 'authorization_code',
      'code': code,
      'redirect_uri': oauth_callback_url,
      'client_id': ENV['MY_TWEET_APP_CLIENT_ID'],
      'client_secret': ENV['MY_TWEET_APP_CLIENT_SECRET'],
    }

    uri.query = URI.encode_www_form(params)

    res = Net::HTTP.post(uri, nil)
    if res.is_a?(Net::HTTPSuccess)
      JSON.parse(res.body)['access_token']
    else
      nil
    end
  end
end

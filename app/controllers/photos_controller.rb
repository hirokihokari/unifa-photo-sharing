class PhotosController < ApplicationController
  def index
    @photos = current_user.photos.order(created_at: :desc)
    @my_tweet_app_authorization_url =
      'https://arcane-ravine-29792.herokuapp.com/oauth/authorize?' + {
        response_type: 'code',
        client_id: ENV['MY_TWEET_APP_CLIENT_ID'],
        redirect_uri: oauth_callback_url,
      }.to_query
  end

  def new
  end

  def create
    @errors = []
    title = params[:title]
    photo = params[:photo]

    if title.present? && photo.present?
      current_user.photos.attach(params[:photo])
      current_user.photos.order(created_at: :desc).first.blob.update!(filename: params[:title])

      redirect_to photos_path
    else
      @errors.push 'タイトルを入力してください' if title.empty?
      @errors.push 'タイトルは30文字以内で入力してください' if title&.size&.>(30)
      @errors.push '写真を選択してください' if photo.nil?

      render :new
    end
  end
end

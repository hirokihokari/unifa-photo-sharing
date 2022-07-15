class PhotosController < ApplicationController
  before_action :authenticate_user

  def index
    @photos = current_user.photos.order(created_at: :desc)
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

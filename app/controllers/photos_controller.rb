class PhotosController < ApplicationController
  before_action :authenticate_user

  Photo = Struct.new(:title, :url)

  def index
    @photos = [
      Photo.new('first', 'http://placekitten.com/200/300'),
      Photo.new('second', 'http://placekitten.com/200/300'),
      Photo.new('third', 'http://placekitten.com/200/300'),
    ]
  end

  def new
  end
end

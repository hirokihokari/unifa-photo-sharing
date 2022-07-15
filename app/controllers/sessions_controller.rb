class SessionsController < ApplicationController
  def new
  end

  def create
    @errors = []

    if user&.authenticate(password)
      session[:user_id] = user.id

      redirect_to photos_path
    else
      if user_id.present? && password.present?
        @errors.push 'ユーザーIDとパスワードが一致するユーザーが存在しません'
      else
        @errors.push 'ユーザーIDを入力してください' if user_id.empty?
        @errors.push 'パスワードを入力してください' if password.empty?
      end

      render :new
    end
  end

  private

  def user
    User.find_by(user_id: user_id)
  end

  def user_id
    params[:user_id]
  end

  def password
    params[:password]
  end
end

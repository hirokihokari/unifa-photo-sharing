class SessionsController < ApplicationController
  def new
  end

  def create
    @errors = []
    user_id = params[:user_id]
    password = params[:password]
    user = User.find_by(user_id: user_id)

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

  def destroy
    session[:user_id] = nil

    redirect_to '/login'
  end
end

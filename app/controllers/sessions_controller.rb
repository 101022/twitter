class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(mail: params[:session][:mail].downcase)
    if user && user.authenticate(params[:session][:password])
      sign_in user
      redirect_to user_path(user), flash: {success: 'ログインしました'}
    else
      render 'new', flash: {error: 'ログインできませんでした'}
    end
  end

  def destroy
    sign_out
    redirect_to root_path
  end
end

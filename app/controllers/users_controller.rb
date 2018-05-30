class UsersController < ApplicationController
  before_action :signed_in_user, only: [:edit, :update]

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def edit
    @user = current_user
  end

  def create
    @user = User.new(user_params)
    if @user.save
      sign_in @user
      redirect_to user_path(@user), flash: {success: 'アカウントを作成しました'}
    else
      render :new, flash: {error: 'アカウント作成できませんでした'}
    end
  end

  def update
    user = current_user
    if user.update_attributes(user_params)
      redirect_to user_path(user), flash: {success: 'プロフィールを更新しました'}
    else
      redirect_to edit_user_path(user), flash: {error: 'プロフィールを更新できませんでした'}
    end
  end

  private

    def user_params
      params.require(:user).permit(:name, :mail, :password, :password_confirmation)
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to root_url unless current_user?(@user)
    end
    helper_method :current_user
end

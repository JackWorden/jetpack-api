class UsersController < ApplicationController
  before_action :set_user, only: [:show]

  skip_before_filter :authenticate, only: [:from_token]

  def from_token
    @current_user = API::GithubAuthenticator.new(params[:code]).user

    if @current_user
      render json: @current_user, status: :ok
    else
      render nothing: true, status: :unauthorized
    end
  end

  def show
    render json: @user
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params[:user]
  end
end

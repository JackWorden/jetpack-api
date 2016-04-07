class UsersController < ApplicationController
  before_action :set_user, only: [:show]

  def from_token
    user = User.first_or_create(github_access_token: params[:token])
    render json: user
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

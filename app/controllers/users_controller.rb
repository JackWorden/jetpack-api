class UsersController < ApplicationController
  before_action :set_user, only: [:show]

  def from_token
    api_response = API::UserFinder.new(params[:token]).call
    render json: api_response.data, status: api_response.status
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

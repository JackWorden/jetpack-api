class UsersController < ApplicationController
  before_action :set_user, only: [:show]

  def from_token
    if params[:token]
      render json: user_from_id, status: 200
    else
      render json: { errors: 'No access token given' }, status: 400
    end
  end

  def show
    render json: @user
  end

  private

  def user_from_id
    user = User.find_by_github_id(github_id)
    return user if user
    User.create(github_id: github_id, name: octokit.user[:login])
  end

  def github_id
    octokit.user[:id]
  end

  def octokit
    @octokit ||= Octokit::Client.new(access_token: params[:token])
  end

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params[:user]
  end
end

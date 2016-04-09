class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Token::ControllerMethods

  before_action :authenticate

  private

  attr_reader :current_user

  def authenticate
    authenticate_or_request_with_http_token do |token, _|
      @current_user = User.find_by(token: token)
    end
  end
end

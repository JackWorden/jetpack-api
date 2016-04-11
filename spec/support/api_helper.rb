module ApiHelper
  include Rack::Test::Methods

  def app
    Rails.application
  end

  def response
    last_response
  end

  def response_json
    JSON.parse(response.to_json)
  end

  def response_body_json
    JSON.parse(response.body)
  end
end

RSpec.configure do |config|
  config.include ApiHelper, type: :api
end

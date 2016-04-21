require 'rails_helper'

describe 'Team Requests', type: :api do
  describe 'GET /teams' do
    context 'When current user has a team' do
      let(:team) { FactoryGirl.create(Team) }
      let!(:user) { FactoryGirl.create(User, token: 'foobar', team: team) }

      it 'should return the team and its users' do
        get '/teams', nil, 'HTTP_AUTHORIZATION' => "Token token=#{user.token}"
        parsed_response = JSON::API.parse(response.body)
        expect(parsed_response.data.id).to eq team.id.to_s
        expect(parsed_response.included[0].id).to eq user.id.to_s
      end
    end

    context 'when the current user does not have a team' do
      let!(:user) { FactoryGirl.create(User, token: 'foobar') }

      it 'should return a bad request' do
        get '/teams', nil, 'HTTP_AUTHORIZATION' => "Token token=#{user.token}"
        expect(response).to be_bad_request
      end
    end
  end
end

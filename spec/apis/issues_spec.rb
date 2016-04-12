require 'rails_helper'

RSpec.describe 'Issue Requests', :no_auth, type: :api do
  let(:user) { FactoryGirl.create(User) }

  describe 'GET /issues/' do
    context 'when there are no issues' do
      it 'should return an empty array' do
        get '/issues'
        expect(response_body_json).to eq []
      end
    end

    context 'when there are issues' do
      before do
        FactoryGirl.create(:issue)
      end

      it 'should return all issues' do
        get 'issues'
        expect(response_body_json.count).to eq Issue.all.count
      end
    end
  end

  describe 'POST /issues' do
    context 'when the creation is successful' do
      let(:project) { FactoryGirl.create(Project) }
      let(:issue_params) do
        {
          format: :json,
          issue: { description: 'Some issue', project_id: project.id }
        }
      end

      it 'should return the issue' do
        post '/issues', issue_params
        expect(response_body_json['id']).to be_present
        expect(response_body_json['attributes']['description']).to eq 'Some issue'
      end
    end

    context 'when the creation is not successful' do
      let(:project) { FactoryGirl.create(Project) }
      let(:issue_params) do
        {
          format: :json,
          issue: { description: '', project_id: project.id, some_thing: 'yolo' }
        }
      end

      it 'should return a bad request status' do
        post '/issues', issue_params
        expect(response.status).to eq 400
      end
    end
  end

  describe 'GET /issues/:id' do
    context 'when the issue exists' do
      let(:issue) { FactoryGirl.create(Issue) }

      it 'should return the issue' do
        get "/issues/#{issue.id}"
        expect(response_body_json['id']).to eq issue.id.to_s
      end
    end

    context 'when the issue does not exist' do
      it 'should return an empty string' do
        expect{ get '/issues/-1' }.to raise_error ActiveRecord::RecordNotFound
      end
    end
  end

  describe 'PATCH /issues/:id' do
    context 'when the update is successful' do
      let(:issue) { FactoryGirl.create(Issue) }
      let(:issue_params) do
        {
          format: :json,
          issue: { project_id: issue.project.id, description: 'yolo' }
        }
      end

      it 'should return the updated issue' do
        patch "/issues/#{issue.id}", issue_params
        expect(response_body_json['attributes']['description']).to eq 'yolo'
      end
    end

    context 'when the update is not successful' do
      let(:issue) { FactoryGirl.create(Issue) }
      let(:issue_params) do
        {
          format: :json,
          issue: { asdfasdf: nil, project_id: -1 }
        }
      end

      it 'should not update the issue' do
        patch "/issues/#{issue.id}", issue_params
        expect(response_body_json['attributes']['description']).to eq issue.description
      end
    end
  end
end

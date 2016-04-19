require 'rails_helper'

RSpec.describe 'Issue Requests', :no_auth, type: :api do
  let(:user) { FactoryGirl.create(User) }

  describe 'GET /project/:project_id/issues' do
    context 'when there are no issues' do
      before do
        @project = FactoryGirl.create(:project)
      end

      it 'should return an empty array' do
        get project_issues_path(@project)
        expect(response_body_json).to eq []
      end
    end

    context 'when there are issues' do
      before do
        @issue = FactoryGirl.create(:issue)
      end

      it 'should return all issues' do
        get project_issues_path(@issue.project)
        expect(response_body_json.count).to eq Issue.all.count
      end
    end
  end

  describe 'POST /project/:project_id/issues' do
    context 'when the creation is successful' do
      let(:project) { FactoryGirl.create(Project) }
      let(:issue_params) { FactoryGirl.attributes_for(Issue, project: project) }

      it 'should return the issue' do
        post project_issues_path(project), issue: issue_params
        expect(response_body_json['id']).to be_present
        expect(response_body_json['attributes']['description']).to eq issue_params[:description]
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
        post project_issues_path(project), issue_params
        expect(response).to be_bad_request
      end
    end
  end

  describe 'GET /issues/:id' do
    context 'when the issue exists' do
      let(:issue) { FactoryGirl.create(Issue) }

      it 'should return the issue' do
        get issue_path(issue)
        expect(response_body_json['id']).to eq issue.id.to_s
      end
    end

    context 'when the issue does not exist' do
      it 'should return an empty string' do
        expect { get '/issues/-1' }.to raise_error ActiveRecord::RecordNotFound
      end
    end
  end

  describe 'PATCH /issues/:id' do
    context 'when the update is successful' do
      let(:issue) { FactoryGirl.create(Issue) }
      let(:issue_params) do
        FactoryGirl.attributes_for(Issue, project: issue.project, description: 'yolo')
      end

      it 'should return the updated issue' do
        patch issue_path(issue), issue: issue_params
        expect(response_body_json['attributes']['description']).to eq 'yolo'
      end
    end

    context 'when the update is not successful' do
      let(:issue) { FactoryGirl.create(Issue) }
      let(:issue_params) do
        FactoryGirl.attributes_for(Issue, description: '')
      end

      it 'should return a bad request status' do
        patch issue_path(issue), issue: issue_params
        expect(response).to be_bad_request
      end
    end
  end

  describe 'PATCH /issues/:id/assignee' do
    let(:user) { FactoryGirl.create(User) }
    let(:issue) { FactoryGirl.create(Issue) }

    context 'when assigning an issue to a user' do
      let(:params) do
        {
          format: :json,
          user_id: user.id,
        }
      end

      it 'should assign the issue to the user' do
        patch assignee_issue_path(issue), params
        expect(issue.reload.assignee).to eq user
      end
    end

    context 'when unassigning an issue to a user' do
      let(:params) { { format: :json } }

      it 'should unassign the issue to the user' do
        patch assignee_issue_path(issue), params
      end
    end
  end
end

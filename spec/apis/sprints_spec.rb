require 'rails_helper'

describe 'Sprints Requests', :no_auth, type: :api do
  let(:user) { FactoryGirl.create(User, team: team) }
  let(:project) { FactoryGirl.create(:project) }

  describe 'GET /sprints' do
    context 'when sprints exist' do
      before do
        FactoryGirl.create_list(Sprint, 5)
      end

      it 'should return all sprints' do
        get sprints_path
        expect(response_body_json.count).to eq Sprint.all.count
      end
    end

    context 'when there are no sprints' do
      it 'should return an empty array' do
        get sprints_path
        expect(response_body_json).to eq []
      end
    end
  end

  describe 'POST /sprints' do
    context 'when the create is successful' do
      let(:params) do
        {
          format: :json,
          sprint: { end_date: '', project_id: project.id }
        }
      end

      it 'should create a new sprint and return it' do
        post sprints_path, params
        expect(response_body_json['id']).to be_present
      end
    end

    context 'when the create is unsuccessful' do
      let(:params) do
        {
          format: :json,
          sprint: { project_id: -1 }
        }
      end

      it 'should have a bad request status' do
        post sprints_path, params
        expect(response).to be_bad_request
      end
    end
  end

  describe 'GET /sprints/:id' do
    context 'when the sprint exists' do
      let(:sprint) { FactoryGirl.create(Sprint) }

      it 'should return the sprint' do
        get sprint_path(sprint)
        expect(response_body_json['id']).to eq sprint.id
      end
    end

    context 'when the sprint does not exist' do
      it 'should have a bad request status' do
        get '/sprints/-1'
        expect(response).to be_bad_request
      end
    end
  end

  describe 'PUT /sprints/:id' do
    let(:sprint) { FactoryGirl.create(Sprint) }
    let(:new_project) { FactoryGirl.create(Project) }

    context 'when the update is successful' do
      let(:params) do
        {
          format: :json,
          sprint: { project_id: new_project.id }
        }
      end

      it 'should update the sprint and return it' do
        put sprint_path(sprint), params
        expect(response_body_json['project_id']).to eq new_project.id
      end
    end

    context 'when the update is not successful' do
      let(:params) do
        {
          format: :json,
          sprint: { id: -1 }
        }
      end

      before do
        allow(sprint).to receive(:update) { false }
      end

      it 'should not update the sprint' do
        put sprint_path(sprint), params
        expect(response_body_json['end_date']).to be_blank
      end
    end
  end

  describe 'DESTROY /sprints/:id' do
    context 'when the delete is successful' do
      let(:sprint) { FactoryGirl.create(Sprint) }

      it 'should delete the sprint' do
        delete sprint_path(sprint)
        expect(Sprint.find_by_id(sprint.id)).to be_nil
      end
    end

    context 'when the delete is not successful' do
      it 'should have a bad request status' do
        delete sprint_path(-1)
        expect(response).to be_bad_request
      end
    end
  end

  describe 'POST /sprints/:id/activate' do
    let(:sprint) { FactoryGirl.create(Sprint, project: project) }

    it 'should make the sprint active for its project' do
      post "/sprints/#{sprint.id}/activate"
      expect(project.reload.active_sprint).to eq sprint
    end
  end

  describe 'POST /sprints/:id/deactivate' do
    let(:sprint) { FactoryGirl.create(Sprint, project: project) }

    before do
      project.active_sprint = sprint
      project.save
    end

    it 'should make the sprint inactive for its project' do
      post "/sprints/#{sprint.id}/deactivate"
      expect(project.reload.active_sprint).to be_nil
    end
  end
end

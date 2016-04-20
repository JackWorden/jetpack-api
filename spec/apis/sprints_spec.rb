require 'rails_helper'

describe 'Sprints Requests', :no_auth, type: :api do
  let(:project) { FactoryGirl.create(:project) }

  describe 'GET /sprints' do
    context 'when there are no sprints' do
      it 'should return an empty array' do
        get project_sprints_path(project)
        expect(response_body_json).to eq []
      end
    end

    context 'when sprints exist' do
      before do
        FactoryGirl.create_list(Sprint, 5, project: project)
      end

      it 'should return all sprints' do
        get project_sprints_path(project)
        expect(response_body_json.count).to eq Sprint.all.count
      end
    end
  end

  describe 'POST /sprints' do
    context 'when the create is successful' do
      let(:sprint_params) { FactoryGirl.attributes_for(Sprint) }

      it 'should create a new sprint and return it' do
        post project_sprints_path(project), sprint: sprint_params
        expect(response_body_json['id']).to be_present
        expect(response_attributes_json['name']).to eq sprint_params[:name]
      end
    end

    context 'when the create is unsuccessful' do
      pending 'model has no validations'
    end
  end

  describe 'GET /sprints/:id' do
    context 'when the sprint exists' do
      let(:sprint) { FactoryGirl.create(Sprint) }

      it 'should return the sprint' do
        get sprint_path(sprint)
        expect(response_body_json['id']).to eq sprint.id.to_s
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
      let(:sprint_params) { FactoryGirl.attributes_for(Sprint, end_date: sprint.end_date + 1.day) }

      it 'should update the sprint and return it' do
        put sprint_path(sprint), sprint: sprint_params
        expect(response_attributes_json['end-date']).to eq sprint_params[:end_date].as_json
      end
    end

    context 'when the update is not successful' do
      pending 'model has no validations'
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

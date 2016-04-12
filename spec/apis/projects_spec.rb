require 'rails_helper'

describe 'Project Requests', :no_auth, type: :api do
  describe 'GET /projects/' do
    context 'when there are no projects' do
      it 'should return an empty array' do
        get '/projects'
        expect(response_body_json).to eq []
      end
    end

    context 'when there are projects' do
      before do
        FactoryGirl.create_list(Project, 5)
      end

      it 'should return all projects in the team' do
        get '/projects'
        expect(response_body_json.count).to eq Project.all.count
      end
    end
  end

  describe 'GET /projects/:id' do
    context 'when the project exists' do
      let(:project) { FactoryGirl.create(Project) }

      it 'should return the project' do
        get project_path(project)
        expect(response_body_json['id']).to eq project.id.to_s
      end
    end

    context 'when the project does not exist' do
      it 'should return an empty string with a bad request status' do
        get project_path(-1)
        expect(response.body).to be_blank
        expect(response).to be_bad_request
      end
    end
  end

  describe 'PUT /projects/:id' do
    let(:project) { FactoryGirl.create(Project) }

    context 'when the update is valid' do
      let(:params) do
        {
          format: :json,
          project: { id: project.id, name: 'Edited Project Name' }
        }
      end

      it 'should update the project and return the updated project' do
        put project_path(project), params
        expect(response_body_json['attributes']['name']).to eq 'Edited Project Name'
      end
    end

    context 'when the update is invalid' do
      context 'when an invalid attribute is updated' do
        let(:params) do
          {
            format: :json,
            project: { id: project.id, invalid_attribute: 'Invalid' }
          }
        end

        it 'should not update the project' do
          put project_path(project), params
          expect(response_attributes_json['name']).to eq project.name
        end
      end

      context 'when a valid attribute is set to an invalid value' do
        let(:params) do
          {
            format: :json,
            project: { id: project.id, name: '' }
          }
        end

        it 'should not update the project and return a bad_request' do
          put project_path(project), params
          expect(response_attributes_json['name']).to eq project.name
          expect(response).to be_bad_request
        end
      end
    end
  end

  describe 'POST /projects' do
    context 'when the create is successful' do
      let(:params) do
        {
          format: :json,
          project: { name: 'Test Project' }
        }
      end

      it 'should create a new project and return it' do
        post projects_path, params
        expect(response_body_json['id']).to be_present
        expect(response_attributes_json['name']).to eq 'Test Project'
      end
    end

    context 'when the create is unsuccessful' do
      let(:params) do
        {
          format: :json,
          project: { name: '' }
        }
      end

      it 'should not create not create a new project' do
        post projects_path, params
        expect(response_body_json['id']).to be_blank
      end

      it 'should have a bad request status' do
        post projects_path, params
        expect(response).to be_bad_request
      end
    end
  end

  describe 'DELETE /projects/:id/' do
    context 'when the project exists' do
      let(:project) { FactoryGirl.create(Project) }

      it 'should delete the project' do
        delete "/projects/#{project.id}"
        expect(Project.find_by_id(project.id)).to be nil
      end
    end

    context 'when the project does not exist' do
      it 'should have a bad request status' do
        delete '/projects/-1'
        expect(response).to be_bad_request
      end
    end
  end
end

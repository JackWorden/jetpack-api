require 'rails_helper'

describe 'Stories Requests', :no_auth, type: :api do
  let(:project) { FactoryGirl.create(Project) }

  describe 'POST /project/:project_id/stories' do
    context 'when the creation is successful' do
      let(:story_params) { FactoryGirl.attributes_for(Story, project: project) }

      it 'should create the story and return it' do
        post project_stories_path(project), story: story_params

        expect(response_body_json['id']).to be_present
        expect(response_body_json['attributes']['title']).to eq story_params[:title]
      end
    end

    context 'when the creation is unsuccessful' do
      let(:story_params) { FactoryGirl.attributes_for(Story, project: project, title: '') }

      it 'should not create the story' do
        post project_stories_path(project), story: story_params
        expect(response_body_json['id']).to be_blank
      end
    end
  end

  describe 'GET stories/:id' do
    context 'when the story exists' do
      let(:story) { FactoryGirl.create(Story, project: project) }

      it 'should return the story' do
        get story_path(story)
        expect(response_body_json['id']).to eq story.id.to_s
      end
    end

    context 'when the story does not exist' do
      it 'should have a bad request status' do
        get story_path(-1)
        expect(response).to be_bad_request
      end
    end
  end

  describe 'PATCH /stories/:id' do
    let(:story) { FactoryGirl.create(Story) }

    context 'when the update is successful' do
      let(:params) do
        {
          format: :json,
          story: { title: 'Another Title' }
        }
      end

      it 'should update the story and return it' do
        patch story_path(story), params
        expect(response_body_json['attributes']['title']).to eq 'Another Title'
      end
    end

    context 'when the update is unsuccessful' do
      let(:params) do
        {
          format: :json,
          story: { title: '' }
        }
      end

      it 'should have a bad request status' do
        patch story_path(story), params
        expect(response).to be_bad_request
      end
    end
  end

  describe 'DELETE /stories/:id' do
    context 'when the story exists' do
      let(:story) { FactoryGirl.create(Story) }

      it 'should delete the story' do
        delete story_path(story)
        expect(Story.find_by_id(story.id)).to be_nil
      end
    end

    context 'when the story does not exist' do
      it 'should have a bad request status' do
        delete story_path(-1)
        expect(response).to be_bad_request
      end
    end
  end
end

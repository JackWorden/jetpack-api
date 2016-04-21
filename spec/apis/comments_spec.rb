require 'rails_helper'

describe 'Comments Requests', :no_auth, type: :api do
  let(:user) { FactoryGirl.create(User) }
  let(:issue) { FactoryGirl.create(Issue) }
  let(:comment) { FactoryGirl.create(Comment) }

  describe 'GET /issues/:id/comments' do
    context 'when the issue has comments' do
      before { FactoryGirl.create_list(Comment, 6, issue: issue) }

      it 'should return all the comments belonging to the issue' do
        get "/issues/#{issue.id}/comments"
        expect(response_body_json.count).to eq issue.comments.count
      end
    end

    context 'when the issue has no comments' do
      it 'should return an empty array' do
        get "/issues/#{issue.id}/comments"
        expect(response_body_json.count).to eq 0
      end
    end
  end

  describe 'POST /issues/:id/comments' do
    context 'when the creation is successful' do
      let(:params) do
        {
          format: :json,
          comment: { body: 'yo', issue_id: issue.id, user_id: user.id }
        }
      end

      it 'should return the comment' do
        post "/issues/#{issue.id}/comments", params
        expect(response_body_json['id']).to be_present
      end
    end

    context 'when the creation is not successful' do
      let(:params) do
        {
          format: :json,
          comment: { body: nil, issue_id: nil, user_id: nil }
        }
      end

      it 'should be a bad request' do
        post "/issues/#{issue.id}/comments", params
        expect(response).to be_bad_request
      end
    end
  end

  describe 'GET /comments/:id' do
    it 'should return the comment' do
      get "/comments/#{comment.id}"
      expect(response_body_json['id']).to eq comment.id.to_s
    end
  end

  describe 'PATCH /comments/:id' do
    context 'when the update is successful' do
      let(:params) do
        {
          format: :json,
          comment: { body: 'Updated body' }
        }
      end

      it 'should return the updated comment' do
        patch "/comments/#{comment.id}", params
        expect(response_body_json['attributes']['body']).to eq 'Updated body'
      end
    end

    context 'when the update is not successful' do
      let(:params) do
        {
          format: :json,
          comment: { body: '' }
        }
      end

      it 'should have a bad request status' do
        patch "/comments/#{comment.id}", params
        expect(response).to be_bad_request
      end
    end
  end

  describe 'DELETE /comments/:id' do
    it 'should delete the comment' do
      delete "comments/#{comment.id}"
      expect { comment.reload }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end

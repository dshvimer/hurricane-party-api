require 'rails_helper'
require Rails.root.join('spec/requests/shared/not_authenticated')

RSpec.describe "Comments", type: :request do
  let(:params) {
    { body: 'i need wata', post_id: post1.id }
  }
  
  let(:user) { 
    User.create username: 'guy', password: 'password' 
  }

  let(:post1) { 
    Post.create user: user, body: 'hello' 
  }

  describe "POST /comments" do

    before do
      post comments_path,
        params: {comment: params},
        headers: headers,
        as: :json
    end

    context 'successfuly' do
      let(:headers) { auth_headers_for(user) }
      subject { response }

      it { is_expected.to have_http_status(:created) }

      it 'returns serialized post' do
        expect(json[:comment]).to eq CommentSerializer.new(Comment.last).to_hash
      end
    end
    
    it_behaves_like 'not authenticated'
  end

end

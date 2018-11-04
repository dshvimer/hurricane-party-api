require 'rails_helper'

RSpec.describe "Posts", type: :request do
  let(:params) {
    { body: 'i need wata' }
  }
  
  let(:user) { 
    User.create username: 'guy', password: 'password' 
  }

  describe "POST /posts" do

    before do
      post posts_path,
        params: {post: params},
        headers: headers,
        as: :json
    end

    context 'successfuly' do
      let(:headers) { auth_headers_for(user) }
      subject { response }

      it { is_expected.to have_http_status(:created) }

      it 'returns serialized post' do
        expect(json[:post]).to eq PostSerializer.new(Post.last).to_hash
      end

    end
  end

  describe "GET /posts" do

    before do
      2.times { user.posts.create(params) }
      get posts_path,
        headers: headers,
        as: :json
    end

    context 'successfuly' do
      let(:headers) { auth_headers_for(user) }
      subject { response }

      it { is_expected.to have_http_status(:ok) }

      it 'returns serialized posts' do
        expect(json[:posts]).to eq user.posts.map { |p| PostSerializer.new(p).to_hash }
      end
    end
  end
end

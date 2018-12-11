require 'rails_helper'

RSpec.describe "Conversations", type: :request do
  let(:user1) { User.create username: 'dave', password: 'password' }
  let(:user2) { User.create username: 'tom', password: 'password' }
  let(:headers) { auth_headers_for(user1) }
  let(:params) {
    { username: user2.username }
  }
  
  describe "POST /conversations" do

    before do
      post conversations_path,
        params: {conversation: params},
        headers: headers,
        as: :json
    end

    context 'creating new' do
      subject { response }

      it { is_expected.to have_http_status(:created) }

      it 'returns serialized conversation' do
        expect(json[:conversation]).to eq ConversationSerializer.new(Conversation.last).to_hash
      end
    end

    context 'exists' do
      before do
        c = Conversation.new
        c.set_members(user1, user2)
        c.save
      end

      subject { response }

      it { is_expected.to have_http_status(:created) }

      it 'returns serialized conversation' do
        expect(json[:conversation]).to eq ConversationSerializer.new(Conversation.last).to_hash
      end
    end
  end

end

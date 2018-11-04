require 'rails_helper'

RSpec.describe "Users", type: :request do

  let(:valid_params) {
    { username: 'guy', password: 'password' }
  }

  let(:invalid_params) {
    { username: '', password: 'password' }
  }

  describe "POST /users" do

    before do
      post users_path,
        params: {user: params},
        as: :json
    end

    context 'valid params' do
      let(:params) { valid_params }
      subject { response }
      it { is_expected.to have_http_status(:created) }
      it 'returns serialized user' do
        expect(json[:user]).to eq UserSerializer.new(User.last).to_hash
      end
    end

    context 'invalid params' do
      let(:params) { invalid_params }
      subject { response }
      it { is_expected.to have_http_status(:unprocessable_entity) }
      it 'returns validation error' do
        expect(json[:username]).to include "can't be blank"
      end
    end

  end
end

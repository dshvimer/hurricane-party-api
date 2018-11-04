require 'rails_helper'

RSpec.describe "UserToken", type: :request do

  let(:valid_params) {
    { username: 'guy', password: 'password' }
  }

  let(:invalid_password) {
    { username: 'guy', password: 'wrongpassword' }
  }

  let(:invalid_username) {
    { username: 'otherguy', password: 'password' }
  }

  describe "POST /user_token" do

    before do
      User.create(valid_params)
      post '/user_token',
        params: {auth: params},
        as: :json
    end

    context 'valid params' do
      let(:params) { valid_params }
      subject { response }
      it { is_expected.to have_http_status(:created) }
      it 'returns serialized user' do
        expect(json).to include :jwt
      end
    end

    context 'wrong password' do
      let(:params) { invalid_password }
      subject { response }
      it { is_expected.to have_http_status(:not_found) }
    end

    context 'username doesnt exist' do
      let(:params) { invalid_username }
      subject { response }
      it { is_expected.to have_http_status(:not_found) }
    end
  end
end

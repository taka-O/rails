require 'rails_helper'

RSpec.describe "Auth", type: :request do
  describe "GET /api/auth/login" do
    let!(:user) { create(:user, email: 'test@test.com', password_digest: BCrypt::Password.create('hogehoge')) }

    context 'when match user' do
      let(:req_params) { { email: 'test@test.com', password: 'hogehoge' } }

      before do
        travel_to Time.zone.now
      end

      it do
        post api_auth_login_path, params: req_params
        expect(response).to have_http_status(:ok)
        body = JSON.parse(response.body)
        expect(body['pid']).to eq user.pid
        expect(body['is_verfied']).to be_falsey
        expect(body['token']).not_to be_nil
      end
    end

    context 'when not match password' do
      let(:req_params) { { email: 'test@test.com', password: 'password' } }

      it do
        post api_auth_login_path, params: req_params
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'when not match email' do
      let(:req_params) { { email: 'testxx@test.com', password: 'hogehoge' } }

      it do
        post api_auth_login_path, params: req_params
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end

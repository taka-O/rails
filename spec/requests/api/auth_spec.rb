require 'rails_helper'

RSpec.describe "Auth", type: :request do
  describe "GET /api/auth/login" do
    let!(:user) { create(:user, email: 'test@test.com', password_digest: BCrypt::Password.create('hogehoge')) }

    context 'when match user' do
      let(:req_params) { { email: 'test@test.com', password: 'hogehoge' } }

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

  describe "GET /api/auth/reset_password_token" do
    include_context 'token authentication header'

    let(:user) { create(:user, email: 'student@test.com', password_digest: BCrypt::Password.create('hogehoge'), role: :student) }

    context 'when match user' do
      let(:req_params) { { email: user.email, reset_url: 'http://hogehoge/reset_password' } }

      it do
        get api_auth_reset_password_token_path, params: req_params, headers: auth_headers(user)
        expect(response).to have_http_status(:no_content)
      end
    end

    context 'when not match email' do
      let(:req_params) { { email: 'testxx@test.com', reset_url: 'http://hogehoge/reset_password' } }

      it do
        get api_auth_reset_password_token_path, params: req_params, headers: auth_headers(user)
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe "PATCH /api/auth/reset_password" do
    include_context 'token authentication header'

    let(:user) { create(:user, email: 'student@test.com', password_digest: BCrypt::Password.create('hogehoge'), role: :student) }

    context 'when match user' do
      let(:token) { user.generate_token_for(:password_reset) }
      let(:req_params) { { token: token, new_password: 'newpassword' } }

      it do
        patch api_auth_reset_password_path, params: req_params, headers: auth_headers(user)
        expect(response).to have_http_status(:no_content)
      end
    end

    context 'when token has been expired' do
      let(:token) do
        trabel_to Time.zone.now.ago(2.days) do
          auth_user.generate_token_for(:password_reset)
        end
      end
      let(:req_params) { { new_password: 'newpassword' } }

      it do
        patch api_auth_reset_password_path, params: req_params, headers: auth_headers(user)
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end

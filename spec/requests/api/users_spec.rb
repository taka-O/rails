require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "GET /api/users/current" do
    include_context 'token authentication header'

    let(:user) { create(:user) }

    it do
      get current_api_users_path, headers: auth_headers(user)
      expect(response).to have_http_status(:ok)
      body = JSON.parse(response.body)
      expect(body['pid']).to eq user.pid
      expect(body['email']).to eq user.email
      expect(body['name']).to eq user.name
    end
  end
end

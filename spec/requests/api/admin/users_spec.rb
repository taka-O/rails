require 'rails_helper'

RSpec.describe "Api::Admin::Users", type: :request do
  describe "GET /api/admin/users" do
    include_context 'jwt authentication header'

    subject(:get_users) { get api_admin_users_path, params: search_params, headers: jwt_headers }

    before do
      create(:user, name: 'アドミン太郎', email: 'admin1@hogehoge.com', role: :admin)
      create(:user, name: '講師太郎', email: 'instructor1@hogehoge.com', role: :instructor)
      create(:user, name: '講師二郎', email: 'instructor2@hogehoge.com', role: :instructor)
      create(:user, name: '講師三郎', email: 'instructor3@hogehoge.com', role: :instructor)
      create(:user, name: '生徒太郎', email: 'student1@hogehoge.com', role: :student)
      create(:user, name: '生徒二郎', email: 'student2@hogehoge.com', role: :student)
      create(:user, name: '生徒三郎', email: 'student3@hogehoge.com', role: :student)
      create(:user, name: '生徒四郎', email: 'student4@hogehoge.com', role: :student)
    end

    context 'without search params' do
      let(:search_params) { {} }

      it do
        get_users
        expect(response).to have_http_status(:ok)
        body = JSON.parse(response.body)
        expect(body.size).to eq 9
      end
    end

    context 'with search params' do
      context 'with role' do
        let(:search_params) { { role: 'instructor'} }

        it do
          get_users
          expect(response).to have_http_status(:ok)
          body = JSON.parse(response.body)
          expect(body.size).to eq 3
          expect(body.map { |u| u['role'] }).to all eq 'instructor'
        end
      end

      context 'with name' do
        let(:search_params) { { name: '太郎'} }

        it do
          get_users
          expect(response).to have_http_status(:ok)
          body = JSON.parse(response.body)
          expect(body.size).to eq 3
          body.each do |user|
            expect(user['name']).to include '太郎'
          end
        end
      end

      context 'with email' do
        let(:search_params) { { email: 'student'} }

        it do
          get_users
          expect(response).to have_http_status(:ok)
          body = JSON.parse(response.body)
          expect(body.size).to eq 4
          body.each do |user|
            expect(user['email']).to include 'student'
          end
        end
      end
      context 'with rolw' do
        let(:search_params) { { role: 'instructor'} }

        it do
          get_users
          expect(response).to have_http_status(:ok)
          body = JSON.parse(response.body)
          expect(body.size).to eq 3
          expect(body.map { |u| u['role'] }).to all eq 'instructor'
        end
      end

      context 'with name and role' do
        let(:search_params) { { name: '三郎', role: 'student' } }

        it do
          get_users
          expect(response).to have_http_status(:ok)
          body = JSON.parse(response.body)
          expect(body.size).to eq 1
          body.each do |user|
            expect(user['name']).to eq '生徒三郎'
          end
        end
      end
    end
  end

  describe "POST /api/admin/users" do
    include_context 'jwt authentication header'

    subject(:post_users) { post api_admin_users_path, params: create_params, headers: jwt_headers }

    let(:create_params) { { name: name, email: email, role: role}.to_json }

    context 'with valid data' do
      let(:name) { 'テスト太郎' }
      let(:email) { 'testtaro@hogehoge.com' }
      let(:role) { 'student' }

      it do
        post_users
        expect(response).to have_http_status(:created)
        body = JSON.parse(response.body)
        expect(body['pid']).not_to be_falsey
        expect(body['name']).to eq name
        expect(body['email']).to eq email
        expect(body['role']).to eq role
      end
    end

    context 'with invalid data' do
      let(:name) { '' }
      let(:email) { '' }
      let(:role) { '' }

      it do
        post_users
        expect(response).to have_http_status(:unprocessable_entity)
        body = JSON.parse(response.body)
        expect(body['errors'].keys).to include 'name'
        expect(body['errors'].keys).to include 'email'
        expect(body['errors'].keys).to include 'role'
      end
    end
  end
end

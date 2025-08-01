require 'rails_helper'

RSpec.describe "Api::Admin::Users::Imports", type: :request do
  describe "POST /api/admin/users/import" do
    include_context 'token authentication header'

    subject(:post_users) { post api_admin_import_index_path, params: { file: upload_file }, headers: headers }

    let!(:user) { create(:user, role: :admin) }
    let(:headers) { auth_headers(user) }
    let(:csv_headers) { 'name,email,role' }
    let(:upload_file) do
      tf = Tempfile.create('test-')
      tf.write(data)
      tf.rewind

      Rack::Test::UploadedFile.new(tf, 'text/csv', original_filename: 'test')
    end

    context 'with valid data' do
      let(:data) do
        <<~EOS
          #{csv_headers}
          "test_admin1","test_admin1@example.com","admin"
          "test_instructor1","test_instructor1@example.com","instructor"
          "test_instructor2","test_instructor2@example.com","instructor"
          "test_student1","test_student1@example.com","student"
          "test_student2","test_student2@example.com","student"
          "test_student3","test_student3@example.com","student"
        EOS
      end

      it { expect { post_users }.to change(User, :count).by(6) }

      it do
        post_users
        expect(response).to have_http_status(:no_content)
      end
    end

    context 'with invalid data' do
      let(:data) do
        <<~EOS
          #{csv_headers}
          "", "", ""
          "test_instructor1","test_instructor1@example.com","instructor"
          "test_instructor2","test_instructor2@example.com","instructor"
          "test_student1","test_student1@example.com","student"
          "test_student2","test_student2@example.com","student"
          "test_student3","test_student3@example.com","student"
        EOS
      end

      before do
        create(:user, email: "test_instructor1@example.com", role: "instructor")
      end

      it { expect { post_users }.not_to change(User, :count) }

      it do
        post_users
        expect(response).to have_http_status(:unprocessable_entity)
        body = JSON.parse(response.body)
        expect(body['errors'].values.flatten).to include "1行目: 名前を入力してください"
        expect(body['errors'].values.flatten).to include "1行目: メールアドレスは不正な値です"
        expect(body['errors'].values.flatten).to include "1行目: 権限は一覧にありません"
        expect(body['errors'].values.flatten).to include "2行目: メールアドレスはすでに登録済みです"
      end
    end
  end
end

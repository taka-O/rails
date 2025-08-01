require 'rails_helper'

RSpec.describe Admin::User::ImportForm do
  describe 'save' do
    subject(:save) { instance.save }

    let(:instance) { described_class.new(file: upload_file) }
    let(:csv_headers) { 'name,email,role' }
    let(:upload_file) do
      tf = Tempfile.create('test-')
      tf.write(data)
      tf.rewind

      ActionDispatch::Http::UploadedFile.new(filename: 'test', tempfile: tf)
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

      it { expect { save }.not_to raise_error }
      it { expect { save }.to change(User, :count).by(6) }
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

      it { expect { save }.not_to change(User, :count) }

      it do
        expect(save).to be_falsey
        expect(instance.error[:errors].values.flatten).to include "1行目: 名前を入力してください"
        expect(instance.error[:errors].values.flatten).to include "1行目: メールアドレスは不正な値です"
        expect(instance.error[:errors].values.flatten).to include "1行目: 権限は一覧にありません"
        expect(instance.error[:errors].values.flatten).to include "2行目: メールアドレスはすでに登録済みです"
      end
    end
  end
end

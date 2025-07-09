require 'rails_helper'

RSpec.describe Admin::CreateUserForm do
  describe 'save' do
    subject(:save) { instance.save }

    let(:instance) { described_class.new(create_params) }

    context 'with valid data' do
      let(:create_params) { { name: 'create', email: 'create@hogehoge', role: 'instructor' } }

      it do
        expect(save).to be_truthy
        expect(instance.name).to eq 'create'
        expect(instance.email).to eq 'create@hogehoge'
        expect(instance.role).to eq 'instructor'
      end
    end

    context 'with blank params' do
      let(:create_params) { { } }

      it do
        expect(save).to be_falsey
        expect(instance.errors.map(&:attribute)).to include :name
        expect(instance.errors.map(&:attribute)).to include :email
        expect(instance.errors.map(&:attribute)).to include :role
      end
    end

    context 'with invalid data' do
      let(:create_params) { { role: 'hogehoge' } }

      it do
        expect(save).to be_falsey
        expect(instance.errors.map(&:attribute)).to include :role
      end
    end

    context 'when email already exists' do
      let(:create_params) { { name: 'create', email: 'create@hogehoge', role: 'instructor' } }

      before do
        create(:user, email: 'create@hogehoge', role: 'instructor')
      end

      it do
        expect(save).to be_falsey
        expect(instance.errors.map(&:attribute)).to include :email
      end
    end
  end
end

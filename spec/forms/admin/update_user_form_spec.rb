require 'rails_helper'

RSpec.describe Admin::UpdateUserForm do
  describe 'save' do
    subject(:save) { instance.save }

    let(:instance) { described_class.new(user: user, **update_params) }
    let(:user) { create(:user, name: 'test', email: 'test@hogehoge', role: :admin) }

    context 'with valid data' do
      let(:update_params) { { name: 'update', email: 'update@hogehoge', role: 'instructor' } }

      it do
        expect(save).to be_truthy
        expect(instance.name).to eq 'update'
        expect(instance.email).to eq 'update@hogehoge'
        expect(instance.role).to eq 'instructor'
      end
    end

    context 'with blank params' do
      let(:update_params) { {} }

      it do
        expect(save).to be_falsey
        expect(instance.errors.map(&:attribute)).to include :name
        expect(instance.errors.map(&:attribute)).to include :email
        expect(instance.errors.map(&:attribute)).to include :role
      end
    end

    context 'with invalid data' do
      let(:update_params) { { name: '', email: '', role: 'hogehoge' } }

      it do
        expect(save).to be_falsey
        expect(instance.errors.map(&:attribute)).to include :role
      end
    end

    context 'when email already exists' do
      let(:update_params) { { name: 'update', email: 'update@hogehoge', role: 'instructor' } }

      before do
        create(:user, email: 'update@hogehoge')
      end

      it do
        expect(save).to be_falsey
        expect(instance.errors.map(&:attribute)).to include :email
      end
    end
  end
end

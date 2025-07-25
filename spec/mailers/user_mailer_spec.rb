require "rails_helper"

RSpec.describe UserMailer, type: :mailer do
    include_context 'token authentication header'

    describe '#reset_password' do
    subject(:mail) do
      described_class.reset_password(user: auth_user, token: token, reset_url: reset_url).deliver_now
      ActionMailer::Base.deliveries.last
    end

    let(:reset_url) { "http://hogehoge:3001/reset_passord" }
    let(:token) { auth_user.generate_token_for(:password_reset) }

    context 'when send_mail' do
      it do
        expect(mail.to.first).to eq(auth_user.email)
        expect(mail.subject).to eq("パスワード再設定")
        expect(mail.body).to include("#{reset_url}?token=#{token}")
      end
    end
  end
end

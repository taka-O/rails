class Auth::ResetPasswordForm < BaseForm
  attribute :password, :string
  attribute :password_confirmation, :string
  attribute :token, :string

  with_options presence: true do
    validates :password
    validates :token
  end
  with_options length: { minimum: 8 } do
    validates :password, confirmation: true
  end

  def save
    return false if invalid?

    @record = User.find_by_token_for(:password_reset, token)
    return true if @record.update(password: password)

    @record.errors.each do |err|
      errors.add(err.attribute, err.message)
    end

    false
  end
end

class Admin::CreateUserForm < BaseForm
  attribute :name, :string
  attribute :email, :string
  attribute :role, :string

  with_options presence: true do
    validates :name
    validates :email
  end
  with_options length: { maximum: 255 } do
    validates :name
    validates :email
  end
  validates :role, inclusion: { in: User.roles.keys }

  def save
    return false if invalid?

    @record = prepare_record
    return true if @record.save

    @record.errors.each do |err|
      errors.add(err.attribute, err.message)
    end

    false
  end

  protected

  def prepare_record
    password = SecureRandom.base64(15)

    User.new(
      pid: SecureRandom.uuid,
      name: name,
      email: email,
      password: password,
      role: role
    )
  end
end
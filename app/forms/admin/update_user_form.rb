class Admin::UpdateUserForm < Admin::CreateUserForm
  attribute :password, :string

  def initialize(user:, **)
    super(**)

    @record = user
    self.name = @record.name if name.blank?
    self.email = @record.email if email.blank?
    self.role = @record.role if role.blank?
  end

  protected

  def prepare_record
    update_params = attributes.select { |_, v| v.present? }
    @record.assign_attributes(update_params)
    @record
  end
end
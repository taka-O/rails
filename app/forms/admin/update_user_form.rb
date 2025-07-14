class Admin::UpdateUserForm < Admin::CreateUserForm
  attribute :password, :string

  def initialize(user:, **)
    super(**)

    @record = user
  end

  protected

  def prepare_record
    update_params = attributes.select { |_, v| v.present? }
    @record.assign_attributes(update_params)
    @record
  end
end

class Admin::User::UpdateForm < Admin::User::CreateForm
  attribute :password, :string

  def initialize(user:, **)
    super(**)

    @record = user
  end

  def prepare_record
    update_params = attributes.select { |_, v| v.present? }
    @record.assign_attributes(update_params)
    @record
  end
end

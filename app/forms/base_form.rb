class BaseForm
  include ActiveModel::Model
  include ActiveModel::Attributes

  attr_reader :record

  def error
    return if errors.blank?

    error_datails = errors.each_with_object({}) do |err, v|
      v[err.attribute] = [] if v[err.attribute].blank?
      v[err.attribute] << err.full_message
    end

    {
      status: "error",
      message: "validation error",
      errors: error_datails
    }
  end
end

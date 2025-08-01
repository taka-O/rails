require 'csv'

class Admin::User::ImportForm < BaseForm
  attribute :file

  validates :file, presence: true
  validate :check_file

  def save
    return false if invalid?

    User.insert_all(@new_records)

    true
  end

  protected

  def check_file
    exsist_emails = User.all.pluck(:email)
    @new_records = []

    CSV.foreach(file.path, headers: true, liberal_parsing: true).with_index(1) do |row, i|
      new_user = Admin::User::CreateForm.new(row.to_hash)

      if new_user.invalid?
        new_user.errors.full_messages.each { |err| errors.add(:base, "#{i}行目: #{err}") }
        next
      end
      if exsist_emails.include?(new_user.email)
        errors.add(:base, "#{i}行目: メールアドレスはすでに登録済みです")
        next
      end

      @new_records << new_user.prepare_record.attributes.slice("pid", "name", "email", "password", "role")
    end
  rescue => e
    errors.add(:base, e.message)
  end
end

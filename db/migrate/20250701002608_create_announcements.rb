class CreateAnnouncements < ActiveRecord::Migration[8.0]
  def change
    create_table :announcements do |t|
      t.references :course, null: false, index: true
      t.string :subject, limit: 128, null: false
      t.string :content, limit: 4096, null: false
      t.integer :mail_flag, limit: 1, null: false
      t.integer :announcement_cd, null: false
      t.datetime :effective_date
      t.string :effective_memo, limit: 128
      t.string :insert_memo, limit: 128
      t.integer :insert_user_id
      t.string :update_memo, limit: 128
      t.integer :update_user_id

      t.timestamps
    end
  end
end

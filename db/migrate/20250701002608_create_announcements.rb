class CreateAnnouncements < ActiveRecord::Migration[8.0]
  def change
    create_table :announcements do |t|
      t.string :title, null: false
      t.text :content, null: false
      t.integer :category, unsigned: true, default: 0, null: false
      t.datetime :start_at
      t.datetime :end_at

      t.timestamps

      t.index %i[start_at end_at category]
    end
  end
end

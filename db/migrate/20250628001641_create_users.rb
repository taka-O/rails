class CreateUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :users do |t|
      t.string :pid, limit: 64, null: false, comment: 'UUID'
      t.string :email, limit: 256, null: false, comment: 'メールアドレス'
      t.string :password_digest, comment: '暗号化パスワード'
      t.string :name, null: false, comment: '名前'
      t.string :rest_password_token, comment: 'パスワードリセットトークン'
      t.string :rest_password_sent_at, comment: 'パスワードリセットトークン送信日時'
      t.string :email_verification_token, comment: 'メール確認トークン'
      t.string :email_verification_token_sent_at, comment: 'メール確認トークン送信日時'
      t.string :email_verification_at, comment: 'メール確認日時'
      t.integer :role, null: false, unsigned: true, comment: 'ロール'

      t.timestamps

      t.index :role
      t.index :pid, unique: true
      t.index :email, unique: true
    end
  end
end

class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users, comment: "ユーザ" do |t|
      t.string :name, comment: "名前"
      t.string :mail, comment: "メールアドレス"
      t.string :password_digest, comment: "パスワード"
      t.string :remember_token, comment: "認証情報"

      t.timestamps
    end
  end
end

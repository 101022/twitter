class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments, comment: "コメント" do |t|
      t.references :user, comment: "ユーザID", foreign_key: true
      t.references :tweet, comment: "ツイートID", foreign_key: true
      t.string :comment, comment: "コメント"
      t.datetime :updated_at, comment: "更新日時"

      t.timestamps
    end
  end
end

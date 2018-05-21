class CreateTweets < ActiveRecord::Migration[5.2]
  def change
    create_table :tweets, comment: "ツイート" do |t|
      t.references :user, foreign_key: true, comment: "ユーザ"
      t.string :tweet, comment: "ツイート"
      t.datetime :updated_at, comment: "更新日時"

      t.timestamps
    end
  end
end

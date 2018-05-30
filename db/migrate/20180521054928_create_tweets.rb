class CreateTweets < ActiveRecord::Migration[5.2]
  def change
    create_table :tweets, comment: "ツイート" do |t|
      t.references :user, foreign_key: true, comment: "ユーザ"
      t.string :body, comment: "ツイート"

      t.timestamps
    end
  end
end

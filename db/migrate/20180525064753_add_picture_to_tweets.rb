class AddPictureToTweets < ActiveRecord::Migration[5.2]
  def change
    add_column :tweets, :picture, :string, comment: "写真"
  end
end

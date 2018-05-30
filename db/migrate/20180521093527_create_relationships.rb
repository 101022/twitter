class CreateRelationships < ActiveRecord::Migration[5.2]
  def change
    create_table :relationships, comment: "リレーションシップ" do |t|
      t.references :following, index: true, comment: "フォロワー"
      t.references :follower, index: true, comment: "フォロー"

      t.timestamps
    end
  end
end

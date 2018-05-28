class Relationship < ApplicationRecord
    belongs_to :follower, class_name: "User", required: true
    belongs_to :following, class_name: "User", required: true
end

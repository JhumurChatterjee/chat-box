class Message < ApplicationRecord
  before_validation { content.to_s.squish! }

  belongs_to :receiver, class_name: "User"
  belongs_to :sender,   class_name: "User"

  validates :content, presence: true, length: { maximum: 255 }

  scope :my_conversation, ->(user1, user2) { where("(sender_id = :user1 AND receiver_id = :user2) OR (sender_id = :user2 AND receiver_id = :user1)", user1: user1, user2: user2) }
end

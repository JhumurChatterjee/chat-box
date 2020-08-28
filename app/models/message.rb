class Message < ApplicationRecord
  before_validation { content.to_s.squish! }

  belongs_to :receiver, class_name: "User"
  belongs_to :sender,   class_name: "User"

  validates :content, presence: true, length: { maximum: 255 }

  scope :my_conversation, ->(user_1, user_2) { where("(sender_id = :user_1 AND receiver_id = :user_2) OR (sender_id = :user_2 AND receiver_id = :user_1)", user_1: user_1, user_2: user_2) }
end

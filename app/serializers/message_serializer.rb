require "action_view/helpers"

class MessageSerializer < ActiveModel::Serializer
  include ActionView::Helpers::DateHelper

  attributes :id, :content, :sender_id, :receiver_id, :sent_at, :sent_by

  def sent_at
    time_ago_in_words(object.created_at) + " ago"
  end

  def sent_by
    object.sender.name
  end
end

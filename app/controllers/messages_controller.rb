class MessagesController < ApplicationController
  before_action :authenticate_user

  def index
    messages = Message.my_conversation(params[:user_id], current_user.id).includes(:sender)
    render_success(:ok, messages, meta: { message: "Messages have been successfully fetched." })
  end

  def create
    message = Message.new(message_params)

    if message.save
      render_success(:created, message, meta: { message: "Message has been successfully created." })
    else
      render_error(:unprocessable_entity, message.errors.full_messages)
    end
  end

  private

  def message_params
    params.require(:message).permit(:receiver_id, :sender_id, :content)
  end
end

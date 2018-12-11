class MessagesController < ApplicationController
  before_action :authenticate_user, only: [:create]

  def create
    @message = Message.new(message_params)
    @message.username = current_user.username

    if @message.save
      @message.conversation.members.each { |member| send_conversation_to(member)}
      render json: @message, status: :created, location: @message
    else
      render json: @message.errors, status: :unprocessable_entity
    end
  end

  private
  
  def send_conversation_to(user)
    NotificationsChannel.broadcast_to(user, serialized_conversation)
  end

  def serialized_conversation
    { conversation: ConversationSerializer.new(@message.conversation) }
  end
    
  def message_params
    params.require(:message).permit(:conversation_id, :body)
  end
end

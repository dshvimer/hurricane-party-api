class ConversationsController < ApplicationController
  before_action :authenticate_user, only: [:index, :create]

  def create
    unless @conversation = Conversation.between(*members)
      @conversation = Conversation.new
      @conversation.set_members(*members)
      @conversation.save
    end

    if @conversation.valid?
      render json: @conversation, status: :created
    else
      render json: @conversation.errors, status: :bad_request
    end
  end

  def index
    @conversations = Conversation.where("participants ILIKE ?", "%#{current_user.username}%")
    render json: @conversations
  end

  private

  def conversation_params
    params.require(:conversation).permit(:username)
  end

  def members
    @members ||= get_members
  end

  def get_members
    u = User.find_by(username: conversation_params[:username])
    [u, current_user]
  end
end

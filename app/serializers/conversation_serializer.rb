class ConversationSerializer < ActiveModel::Serializer
  attributes :id, :participants

  has_many :messages, serializer: MessageSerializer
end

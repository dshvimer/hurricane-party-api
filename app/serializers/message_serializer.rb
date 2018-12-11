class MessageSerializer < ActiveModel::Serializer
  attributes :id, :username, :body, :created_at
end

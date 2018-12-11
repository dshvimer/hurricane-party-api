class PostSerializer < ActiveModel::Serializer
  attributes :id, :body, :created_at

  belongs_to :user, serializer: UserSerializer
  has_many :comments, serializer: CommentSerializer
end

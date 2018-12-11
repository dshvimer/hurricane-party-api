class PostsController < ApplicationController
  before_action :authenticate_user, only: [:index, :create]

  # GET /posts
  def index
    if query_params[:sort] == 'nearby'
      @posts = Post.close_to(current_user)
    else
      @posts = Post.order(created_at: :desc)
    end

    render json: @posts
  end

  # POST /posts
  def create
    @post = Post.new(post_params)
    @post.user = current_user

    if @post.save
      render json: @post, status: :created
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  private
    # Only allow a trusted parameter "white list" through.
    def post_params
      params.require(:post).permit(:user_id, :body)
    end

    def query_params
      params.permit(:sort)
    end
end

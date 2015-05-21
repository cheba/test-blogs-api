class PostsController < ApplicationController
  def index
    posts = Post.accessible_by(current_ability, :read)

    authorize! :read, posts

    respond_to do |format|
      format.json { render json: posts }
    end
  end

  def show
    post = Post.find(params[:id])

    authorize! :read, post

    respond_to do |format|
      format.json { render json: post }
    end
  end

  def create
    post = Post.new(post_params)

    authorize! :create, post

    respond_to do |format|
      format.json do
        if post.save
          render json: post
        else
          render json: { errors: post.errors.full_messages }, status: 500
        end
      end
    end
  end

  def update
    post = Post.find(params[:id])

    authorize! :update, post

    respond_to do |format|
      format.json do
        if post.update_attributes(post_params)
          render json: post
        else
          render json: { errors: post.errors.full_messages }, status: 500
        end
      end
    end
  end

  def destroy
    post = Post.find(params[:id])

    authorize! :destroy, post

    post.destroy

    respond_to do |format|
      format.json { render nothing: true }
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :blog_id)
  end
end

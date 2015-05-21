class BlogsController < ApplicationController
  def index
    blogs = Blog.accessible_by(current_ability, :read)

    authorize! :read, blogs

    respond_to do |format|
      format.json { render json: blogs }
    end
  end

  def show
    blog = Blog.find(params[:id])

    authorize! :read, blog

    respond_to do |format|
      format.json { render json: blog }
    end
  end

  def create
    blog = Blog.new(blog_params)

    authorize! :create, blog

    respond_to do |format|
      format.json do
        if blog.save
          render json: blog
        else
          render json: { errors: blog.errors.full_messages }, status: 400
        end
      end
    end
  end

  def update
    blog = Blog.find(params[:id])

    authorize! :update, blog

    respond_to do |format|
      format.json do
        if blog.update_attributes(blog_params)
          render json: blog
        else
          render json: { errors: blog.errors.full_messages }, status: 400
        end
      end
    end
  end

  def destroy
    blog = Blog.find(params[:id])

    authorize! :destroy, blog

    blog.destroy

    respond_to do |format|
      format.json { render nothing: true }
    end
  end

  private

  def blog_params
    params.require(:blog).permit(:title, :user_id)
  end
end

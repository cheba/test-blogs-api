class BlogsController < ApplicationController
  def index
    blogs = Blog.all

    respond_to do |format|
      format.json { render json: blogs }
    end
  end

  def show
    blog = Blog.find(params[:id])

    respond_to do |format|
      format.json { render json: blog }
    end
  end

  def create
    blog = Blog.new(blog_params)

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

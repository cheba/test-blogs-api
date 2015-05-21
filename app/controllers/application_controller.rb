class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  #protect_from_forgery with: :exception

  check_authorization :unless => :devise_controller?

  rescue_from CanCan::AccessDenied do |exception|
    render json: { errors: [exception.message] }, status: 401
  end

  rescue_from ActiveRecord::RecordNotFound do |exception|
    render json: { errors: [exception.message] }, status: 404
  end
end

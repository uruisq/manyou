class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  helper_method :current_user
  before_action :login_required

  rescue_from Exception, with: :error_500 unless Rails.env.development?
  rescue_from AbstractController::ActionNotFound, with: :error_404 unless Rails.env.development?
  rescue_from ActionController::RoutingError, with: :error_404 unless Rails.env.development?
  rescue_from ActiveRecord::RecordNotFound, with: :error_404 unless Rails.env.development?

  def error_500
    render file: "#{Rails.root}/public/500.html", layout: false, status: 500
  end
  def error_404
    render file: "#{Rails.root}/public/404.html", layout: false, status: 404
  end
end

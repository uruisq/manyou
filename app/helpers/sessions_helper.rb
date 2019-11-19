module SessionsHelper
  def log_in(user)
    session[:user_id] = user.id
  end
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end
  def current_user?(user)
    user == current_user
  end
  def logged_in?
    current_user.present?
  end
  def login_required
    redirect_to login_url unless current_user
  end
end
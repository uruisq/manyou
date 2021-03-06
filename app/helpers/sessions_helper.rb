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
  def admin_user_new_or_edit
    if action_name == 'new' || action_name == 'create'
      admin_users_path
    elsif action_name == 'edit'
      admin_user_path
    end
  end
end
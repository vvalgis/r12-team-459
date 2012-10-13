class ApplicationController < ActionController::Base
  protect_from_forgery

  def after_sign_in_path_for(resource)
    stored_location_for(resource) || resource.is_a?(User) ? dashboard_path : super
  end

  def home
    @users_count = User.count
    @entries_count = Entry.count
  end

end

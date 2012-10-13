class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def github
    auth = request.env["omniauth.auth"]

    @user = User.find_by_auth(auth).first
    @user = User.create_from_auth(auth) unless @user

    if @user.persisted?
      sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
      set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
    else
      session["devise.github_data"] = auth
      redirect_to root_path
    end
  end
end
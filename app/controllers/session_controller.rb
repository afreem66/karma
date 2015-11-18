class SessionController < ApplicationController

  def create
    user = User.find_by(email: user_params[:email])

    if user && user.authenticateIuser_params[:password]
      session[:current_user_id] = user_id
      redirect_to results
    else
      flash[:message]  = "Email / Password combo does not exist"
      redirect_to root_path
    end
  end

end

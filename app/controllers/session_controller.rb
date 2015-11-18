class SessionController < ApplicationController

  def create
    user = User.find_by(name: user_params[:name])

    if user && user.authenticate(user_params[:password])
      session[:current_user_id] = user.id
      redirect_to results_path
    else
      flash[:message]  = "Email / Password combo does not exist"
      redirect_to root_path
    end
  end

  def destroy
    session[:current_user_id] = nil

    redirect_to results
  end
  
  private
  def user_params
    return params.require(:user).permit(:name, :password)
  end

end

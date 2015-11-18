class UsersController < ApplicationController

def create
  redirect_to users_path
end

private
def user_params
  return params.require(:user).permit(:email, :password)
end

end

class UsersController < ApplicationController

def create
  @user = User.new(user_params)

  if @user.save
      redirect_to find_path
  else
    redirect_to root_path
  end



end

private
def user_params
  return params.require(:user).permit(:name, :password)
end

end

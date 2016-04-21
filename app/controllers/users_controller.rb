class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    user_params = params.require(:user).permit(:first_name, :last_name, :email, :password, :confirm_password)
    @user = User.new user_params
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path, notice: "Account Created Successfully!"
    else
      flash[:alert] = "You did a bad man ting"
      render :new
    end
  end

end

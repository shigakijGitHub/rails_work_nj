class SelectController < ApplicationController
  def top
    @teams = TeamMaster.all
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      render '/logs/top'
    else
      render 'new'
    end
  end

  def user_params
    params.require(:user).permit(:login_id, :name, :mail_adress, :password, :favorite1)
  end

end

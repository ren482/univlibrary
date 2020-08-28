class UsersController < ApplicationController
  def index
  end

  def show
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    
    if @user.save
      flash[:success] = "ありがとうございます。あなたの読書がより有意義になる見込み9割です。"
      redirect_to "#"
    else
      flash.now[:danger] = "申し訳ないですが登録し直してください。すぐに終わります。"
      render :new 
    end
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :major, :academic_level, :profile_content)
  end
  
end

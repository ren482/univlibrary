class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @books = @user.favbooks
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
  
  def mypage
    @user = current_user
  end
    
  def myreviews
    @reviews = current_user.reviews.order(id: :desc).page(params[:page]).per(25)
  end
  
  def mybookshelf
    @books = current_user.favbooks
    @user = current_user
    @book = current_user.mybooks.build
    @review = current_user.reviews.build
  end
  
  def auserreviews
     @user = User.find(params[:id])
  end
  
 
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :major, :academic_level, :profile_content)
  end
  
end

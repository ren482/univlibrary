class UsersController < ApplicationController
  
  def index
    if params[:academic_level].nil? && params[:major].nil?
      @users = User.all
    elsif params[:academic_level].nil?
    @users = User.where(major: params[:major])
    elsif params[:major].nil?
      @users = User.where(academic_level: params[:academic_level])
    end
    
    @random_user = User.where( 'id >= ?', rand(User.first.id..User.last.id) ).first

    
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
      redirect_to login_url
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
    # views/users/newのフォームの宛先をmodelではなくてurlにしたため、require(:users)を消した。
    # modelでなくurlにした理由は、/users にpostメソッドを飛ばした時に、①users#index②users#createという2通りの受取先があり、それらを区別したかったから。
    # 区別の方法は、データの宛先をmodelではなくてurlにするものしか知らない。
    params.permit(:name, :email, :password, :password_confirmation, :major, :academic_level, :profile_content)
  end
  
end

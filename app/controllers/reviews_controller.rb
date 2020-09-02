class ReviewsController < ApplicationController
  def index
    @reviews = Review.order(id: :desc).page(params[:page]).per(25)
  end

  def new
    book = Book.find(params[:id])
    @review = current_user.reviews.build(book_id: book.id)
  end

  def create
    @review = current_user.reviews.build(review_params)
    if @review.save
      flash[:success] = "アウトプットが完了しました！また今度は別の本を読んだ時に是非！！"
      redirect_to mypage_users_url
    else
      flash.now[:danger] = "アウトプットの保存に失敗しました申し訳ねえです。もう一度やり直して欲しいです！"
      render :new
    end
  end

  def destroy
  end

  def edit
  end

  def update
  end
  
  def usersReviewsIndex
    book = Book.find(params[:id])
    @reviews = book.reviews
  end
  

  
  private
  def review_params
    params.require(:review).permit(:purpose, :sentences, :discovery, :summary, :book_id)
  end
end

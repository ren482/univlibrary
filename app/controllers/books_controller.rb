class BooksController < ApplicationController
  before_action :correct_user, only: [:destroy]
  
  def index
    if params[:genre].nil?
    @books = Book.order(id: :desc).page(params[:page]).per(25)
    else
    @books = Book.where(genre: params[:genre]).page(params[:page]).per(25)
    end
    
    @random_book = Book.where( 'id >= ?', rand(Book.first.id..Book.last.id) ).first
    
    @para_genre = params[:genre]
  end
  
  def new
    @book = Book.new
  end
  

  def create
    @book = Book.new(book_params)
    if @book.save 
      flash[:success] ="もうワンクリックで追加できます頑張って下さい"
      redirect_to complete_book_url(@book)
    else
      flash.now[:danger] ="本棚に追加できませんでした"
      render :new
    end
  end
  
  def complete
    @book = Book.last
  end

  def destroy
    @book.destroy
    flash[:success] = "本を削除しました"
    redirect_to mybookshelf_users_url
  end

  def show
  end

  def edit
  end

  def update
  end
  
  def bookReviews
    @book = Book.find(params[:id])
    @reviews = @book.reviews
  end
  
  private
  
  def book_params
    params.permit(:title, :status, :genre)
  end
  
  def correct_user
    @book = current_user.mybooks.find_by(id: params[:id])
    unless @book
      redirect_to root_url
    end
  end
  
end

class BooksController < ApplicationController
  def index
    @books = Book.order(id: :desc).page(params[:page]).per(25)
    @gakubu_books = Book.all
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
    params.require(:book).permit(:title, :status, :genre)
  end
end

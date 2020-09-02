class MybooksController < ApplicationController
  def create
    book = Book.find(params[:book_id])
    current_user.addToBookshelf(book)
    flash[:success] = "本棚に追加しましたよ～～"
    redirect_to mybookshelf_users_url
  end

  def destroy
  end
end

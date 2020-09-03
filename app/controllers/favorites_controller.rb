class FavoritesController < ApplicationController
  def create
    review = Review.find(params[:like_id])
    current_user.like(review)
    flash[:success] = "アウトプットにいいねをしました。他ユーザのモチベ向上に伴い、引き続き色んなアウトプットが見られるかもですね。"
    redirect_to root_url
  end

  
end

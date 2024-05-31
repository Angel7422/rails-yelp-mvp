class ReviewsController < ApplicationController
  def new
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review = Review.new
  end

  def create
    # construire review avec content
    @review = Review.new(review_params)
    # trouver le restaurant
    @restaurant = Restaurant.find(params[:restaurant_id])
    # associer la review avec le restaurant
    @review.restaurant = @restaurant
    # save le restaurant
    if @review.save # si cela ne passe pas, ca renvoie false
      redirect_to restaurant_path(@restaurant)
    else
      render "restaurants/show", status: :unprocessable_entity
      # redirect_to restaurant_path(@restaurant)
    end
  end

  def destroy
    # DELETE
    @review = Review.find(params[:id])
    @review.destroy
    # GET
    redirect_to restaurant_path(@review.restaurant), status: :see_other
  end

  private

  def review_params
    params.require(:review).permit(:content, :rating)
  end
end

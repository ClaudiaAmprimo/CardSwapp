class CardsController < ApplicationController
  def index
    if params[:query].present?
      @cards = policy_scope(Card).where("name ILIKE ?", "%#{params[:query]}%")
    else
      @cards = policy_scope(Card)
    end
  end

  def show
    @card = Card.find(params[:id])
    authorize @card
  end
end

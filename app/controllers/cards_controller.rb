class CardsController < ApplicationController
  def index
    @cards = policy_scope(Card)
    # @cards = Card.all
  end

  def show
    @card = Card.find(params[:id])
    authorize @card
  end
end

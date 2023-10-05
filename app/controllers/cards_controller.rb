class CardsController < ApplicationController
  def index
    @card = Card.all
    authorize @cards
  end

  def show
    @card = Card.find(params[:id])
    authorize @cards
  end
end

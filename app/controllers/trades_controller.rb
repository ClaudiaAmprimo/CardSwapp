class TradesController < ApplicationController
  def index
    @trade = Trade.all
    authorize @trades
  end

  def show
    @trade = Trade.find(params[:id])
    authorize @trade
  end
end

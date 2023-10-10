class TradesController < ApplicationController
  def index
    @trades = policy_scope(Trade)
    @trades = Trade.all
  end

  def show
    @trade = Trade.find(params[:id])
    authorize @trade
  end
end

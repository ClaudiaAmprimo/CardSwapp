class TradesController < ApplicationController
  def index
    @trade = Trade.all
  end

  def show
    @trade = Trade.find(params[:id])
  end
end

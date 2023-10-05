class TradeItemsController < ApplicationController

  def index
    @trade_items = TradeItem.all
    authorize @trade_items
  end

  def show
    @trade_item = TradeItem.find(params[:id])
    authorize @trade_item
  end
end

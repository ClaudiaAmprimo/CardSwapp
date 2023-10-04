class TradeItemsController < ApplicationController

  def index
    @trade_items = TradeItem.all
  end

  def show
    @trade_item = TradeItem.find(params[:id])
  end
end

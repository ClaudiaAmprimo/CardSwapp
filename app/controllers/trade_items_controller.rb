class TradeItemsController < ApplicationController

  def index
    @wantlists = policy_scope(Wantlist)
    @trade_items = TradeItem.all
  end

  def show
    @trade_item = TradeItem.find(params[:id])
    authorize @trade_item
  end
end

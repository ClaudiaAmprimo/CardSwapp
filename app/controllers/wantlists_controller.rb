class WantlistsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_wantlist, only: [:show, :edit, :update, :destroy]

  def index
    @wantlists = policy_scope(Wantlist)
    @wantlists = Wantlist.all
  end

  def show
  end

  def new
    @wantlist = Wantlist.new
    begin
      authorize @wantlist
    rescue Pundit::NotAuthorizedError => e
      Rails.logger.debug("Authorization failed for user: #{current_user.inspect}")
      Rails.logger.error("Authorization error: #{e.message}")
    end
  end

  def create
    @wantlist = Wantlist.new(wantlist_params)
    @wantlist.user = current_user
    authorize @wantlist

    if @wantlist.save
      redirect_to @wantlist, notice: 'Wantlist was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @wantlist.update(wantlist_params)
      redirect_to @wantlist, notice: 'Wantlist was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @wantlist.destroy
    redirect_to wantlists_url, notice: 'Wantlist was successfully destroyed.'
  end

  def add_to_wantlist
    @wantlist = current_user.build_wantlist(wantlist_params) unless current_user.wantlist
    @wantlist ||= current_user.wantlist
    card = Card.find(params[:card_id])
    authorize @wantlist

    unless @wantlist.cards.include?(card)
      @wantlist.cards << card
      flash[:notice] = "Card added to your wantlist!"
    else
      flash[:alert] = "You already have this card in your wantlist."
    end

    redirect_to cards_path
  end


  private

  def set_wantlist
    authorize @wantlist
    @wantlist = Wantlist.find(params[:id])
  end

  def wantlist_params
    params.require(:wantlist).permit(:user_id, :card_id)
  end
end

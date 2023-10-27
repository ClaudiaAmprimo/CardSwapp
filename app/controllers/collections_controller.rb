class CollectionsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_collection, only: [:show, :edit, :update, :destroy]

  def index
    @collections = policy_scope(Collection)
  end

  def show
  end

  def new
    @collection = Collection.new
    @cards = Card.all
    begin
      authorize @collection
    rescue Pundit::NotAuthorizedError => e
      Rails.logger.debug("Authorization failed for user: #{current_user.inspect}")
      Rails.logger.error("Authorization error: #{e.message}")
    end
  end

  def create
    @collection = Collection.new
    @collection.user = current_user
    authorize @collection

    if @collection.save
      if params[:collection][:card_ids].present?
        selected_cards = Card.find(params[:collection][:card_ids])
        @collection.cards << selected_cards
      end
      redirect_to @collection, notice: 'Collection was successfully created.'
    else
      render :new
    end
  end


  def edit
  end

  def update
    if @collection.update(collection_params)
      redirect_to @collection, notice: 'Collection was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @collection.destroy
    redirect_to collections_url, notice: 'Collection was successfully destroyed.'
  end

  def add_to_collection
    @collection = current_user.build_collection(collection_params) unless current_user.collection
    @collection ||= current_user.collection
    card = Card.find(params[:card_id])
    authorize @collection 

    unless @collection.cards.include?(card)
      @collection.cards << card
      flash[:notice] = "Card added to your collection!"
    else
      flash[:alert] = "You already have this card in your collection."
    end

    redirect_to cards_path
  end


  private

  def set_collection
    @collection = Collection.find(params[:id])
    authorize @collection
  end

  def collection_params
    params.require(:collection).permit(:user_id)
  end

end

class WantlistsController < ApplicationController
  before_action :set_wantlist, only: [:show, :edit, :update, :destroy]

  def index
    @wantlists = Wantlist.all
  end

  def show
  end

  def new
    @wantlist = Wantlist.new
  end

  def create
    @wantlist = Wantlist.new(wantlist_params)
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

  private
  
  def set_wantlist
    @wantlist = Wantlist.find(params[:id])
  end

  def wantlist_params
    params.require(:wantlist).permit(:user_id, :card_id)
  end
end

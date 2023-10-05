class RequestsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :destroy, :accept, :reject]
  before_action :set_request, only: [:destroy, :accept, :reject]

  def new
    @request = Request.new
    authorize @request
  end

  def create
    @request = Request.new(request_params)
    @request.sender_id = current_user.id
    authorize @request

    if @request.save
      redirect_to @request, notice: 'Request was successfully created.'
    else
      render :new
    end
  end

  def destroy
    @request.destroy
    redirect_to requests_url, notice: 'Request was successfully destroyed.'
  end

  def accept
    if @request.update(status: 'accepted')
      redirect_to @request, notice: 'Request was accepted.'
    else
      redirect_to @request, alert: 'Failed to accept request.'
    end
  end

  def reject
    @request.update(status: 'rejected')
    redirect_to @request, notice: 'Request was rejected.'
  end

  private

  def set_request
    @request = Request.find(params[:id])
    authorize @request
  end

  def request_params
    params.require(:request).permit(:receiver_id, :trade_id, :status)
  end
end

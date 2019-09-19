class BuyRequestsController < ApplicationController
  before_action :set_buy_request, only: [:update, :show]

  def index
    if params[:keyword].present?
      @buy_requests = current_user.buy_requests.search_buy_requests(params[:keyword])
    else
      @buy_requests = current_user.buy_requests.page(params[:page]).per(10)
    end
  end

  def show
    respond_to do |format|
      format.js
    end
  end

  def new
    @buy_request = current_user.buy_requests.build
    respond_to do |format|
      format.js
    end
  end

  def create
    @buy_request = current_user.buy_requests.build(buy_request_params)
    if @buy_request.save
      @buy_requests = current_user.buy_requests.page(params[:page]).per(10)
      respond_to do |format|
        format.js
      end
    else
      render :index
    end
  end

  def update
    @buy_request.update_attribute(:state, params[:buy_request][:state])
    respond_to do |format|
      format.js
    end
  end

  private

  def buy_request_params
    params.require(:buy_request).permit(:device_name, :reference_link, :reason, :state)
  end

  def set_buy_request
    @buy_request = BuyRequest.find(params[:id])
  end
end

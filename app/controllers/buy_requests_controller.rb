class BuyRequestsController < ApplicationController
  def index
    if params[:keyword].present?
      @buy_requests = current_user.buy_requests.search_buy_requests_by_device_name_or_reason_or_state(params[:keyword])
    else
      @buy_requests = current_user.buy_requests.page(params[:page]).per(10)
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
    @buy_request = BuyRequest.find(params[:id])
    @buy_request.update_attribute(:state, params[:buy_request][:state])
    respond_to do |format|
      format.js
    end
  end

  private

  def buy_request_params
    params.require(:buy_request).permit(:device_name, :reason, :state)
  end
end

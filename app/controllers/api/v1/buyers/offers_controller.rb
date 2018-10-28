class Api::V1::Buyers::OffersController < ApplicationController
  before_action :authenticate_buyer!, :buyer_signed_in?

  def index
    render json: current_buyer.offers
  end
end

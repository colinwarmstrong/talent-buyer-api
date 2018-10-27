class Api::V1::Buyers::VenuesController < ApplicationController
  before_action :authenticate_buyer!, :buyer_signed_in?

  def index
    render json: current_buyer.venues
  end
end

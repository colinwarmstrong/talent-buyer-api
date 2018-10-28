class Api::V1::Buyers::OffersController < ApplicationController
  before_action :authenticate_buyer!, :buyer_signed_in?

  def index
    if params[:date]
      render json: current_buyer.offers.where(date: Date.parse(params[:date]))
    else
      render json: current_buyer.offers
    end
  end

  def update
    offer = Offer.find_by_id(params[:offer_id])
    if offer
      offer.update(offer_params)
      render json: offer, status: 200
    else
      render json: {message: 'Invalid Input'}, status: 404
    end
  end

  private

  def offer_params
    params.permit(:guarantee, :bonuses,
                  :radius_clause, :total_expenses, :gross_potential,
                  :door_times, :age_range, :merch_split, :date, :status)
  end
end

class Api::V1::OffersController < ApplicationController
  before_action :authenticate_buyer!, :buyer_signed_in?

  def create
    offer = Offer.create(offer_params)
    if offer.id
      render json: offer, status: 201
    else
      render json: { message: 'Invalid offer parameters.' }, status: 400
    end
  end

  private

  def offer_params
    params.permit(:show_id, :artist_id, :guarantee, :bonuses,
                  :radius_clause, :total_expenses, :gross_potential,
                  :door_times, :age_range, :merch_split)
  end
end

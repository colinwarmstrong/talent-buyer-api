class Api::V1::OffersController < ApplicationController
  def create
    offer = Offer.create(offer_params)
    if offer
      render json: offer, status: 201
    else
      render json: { message: 'Invalid offer parameters' }, status: 400
    end 
  end

  private

  def offer_params
    params.require(:offer).permit(:show_id, :artist_id, :guarantee, :bonuses,
                                  :radius_clause, :total_expenses, :gross_potential,
                                  :door_times, :age_range, :merch_split)
  end
end

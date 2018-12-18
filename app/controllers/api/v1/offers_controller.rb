class Api::V1::OffersController < ApplicationController
  before_action :authenticate_buyer!, :buyer_signed_in?

  def create
    offer = Offer.create(offer_payload)
    if offer.id
      render json: offer, status: 201
    else
      render json: { message: 'Invalid offer parameters.' }, status: 400
    end
  end

  private

  def offer_params
    params.permit(:buyer_id, :artist_name, :venue_id, :guarantee, :bonuses,
                  :radius_clause, :total_expenses, :gross_potential,
                  :door_times, :age_range, :merch_split, :date, :status)
  end

  def offer_payload
    { buyer_id: offer_params[:buyer_id],
      artist_name: offer_params[:artist_name],
      artist_id: artist_id,
      venue_id: offer_params[:venue_id],
      guarantee: offer_params[:guarantee],
      bonuses: offer_params[:bonuses],
      radius_clause: offer_params[:radius_clause],
      total_expenses: offer_params[:total_expenses],
      gross_potential: offer_params[:gross_potential],
      door_times: offer_params[:door_times],
      age_range: offer_params[:age_range],
      merch_split: offer_params[:merch_split],
      date: offer_params[:date],
      status: offer_params[:status].to_i }
  end

  def artist_id
    if offer_params[:artist_name]
      @artist_id ||= Artist.find_by(name: offer_params[:artist_name]).id
    else
      0
    end
  end
end

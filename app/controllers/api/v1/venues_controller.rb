class Api::V1::VenuesController < ApplicationController
  before_action :authenticate_buyer!, :buyer_signed_in?

  def show
    if venue
      render json: venue, status: 200
    else
      render json: { message: 'Venue does not exist' }, status: 404
    end
  end

  def create
    venue = Venue.where(venue_params).first_or_create
    if venue.id
      current_buyer.buyer_venues.create(venue_id: venue.id)
      render json: venue, status: 201
    else
      render json: { message: 'Invalid venue parameters' }, status: 400
    end
  end

  private

  def venue_params
    params.permit(:name, :street_address, :city, :state, :zip, :capacity, :venue_songkick_id)
  end

  def venue
    @venue ||= Venue.find_by(id: params[:id])
  end
end

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
    venue = current_buyer.venues.find_by_venue_songkick_id(venue_params[:venue_songkick_id]) || current_buyer.venues.create(venue_params)
    if venue.id
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

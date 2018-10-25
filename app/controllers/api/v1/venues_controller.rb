class Api::V1::VenuesController < ApplicationController

  def show
    if venue
      render json: venue, status: 200
    else
      render json: { message: 'Venue does not exist' }, status: 404
    end
  end

  def create
    venue = Venue.create(venue_params)
    if venue.id
      render json: venue, status: 201
    else
      render json: { message: 'Invalid venue parameters' }, status: 400
    end
  end

  private

  def venue_params
    params.require(:venue).permit(:name, :street_address, :city, :state, :zip, :capacity)
  end

  def venue
    @venue ||= Venue.find_by(id: params[:id])
  end
end

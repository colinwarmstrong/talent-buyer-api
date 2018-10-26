class Api::V1::ShowsController < ApplicationController
  before_action :authenticate_buyer!, :buyer_signed_in?

  def create
    show = Show.create(show_params)
    if show.id
      render json: show, status: 201
    else
      render json: { message: 'Invalid show parameters.' }, status: 400
    end
  end

  private

  def show_params
    params.permit(:venue_id, :date, :status)
  end
end

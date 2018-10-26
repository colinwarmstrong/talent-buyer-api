class Api::V1::ArtistsController < ApplicationController
  before_action :authenticate_user!

  def create
    artist = Artist.create(artist_params)
    if artist.id
      render json: artist, status: 201
    else
      render json: { message: 'Invalid artist parameters.' }, status: 400
    end
  end

  private

  def artist_params
    params.permit(:name, :agency, :genres, :songkick_id, :popularity, :image_url, :spotify_url, :spotify_followers, :spotify_id)
  end
end

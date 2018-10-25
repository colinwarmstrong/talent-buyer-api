class Api::V1::ArtistsController < ApplicationController
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
    params.permit(:name, :agency, :artist_songkick_id, :artist_spotify_id)
  end
end

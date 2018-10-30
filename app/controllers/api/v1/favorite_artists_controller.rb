class Api::V1::FavoriteArtistsController < ApplicationController
  def index
    render json: current_buyer.artists, status: 200
  end

  def create
    artist = Artist.find_by_id(params[:artist_id])
    if artist
      new_favorite_artist = current_buyer.favorite_artists.create(favorite_artist_params)
      render json: { message: "Added #{artist.name} to favorites", data: new_favorite_artist }, status: 201
    else
      render json: {message: "Artist not found"}, status: 400
    end
  end

  def destroy
    favorite_artist = current_buyer.favorite_artists.includes(:artist).find_by_artist_id(params[:id])
    if favorite_artist
      favorite_artist.destroy
      render json: {message: "#{favorite_artist.artist.name} removed from favorites"}, status: 200
    else
      render json: {message: "Favorite Artist not found"}, status: 404
    end
  end

  private
  def favorite_artist_params
    params.permit(:artist_id)
  end
end

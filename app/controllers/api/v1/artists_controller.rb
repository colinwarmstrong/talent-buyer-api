require './app/modules/artist_utilities'

class Api::V1::ArtistsController < ApplicationController
  before_action :authenticate_buyer!, :buyer_signed_in?
  include ArtistUtilities

  def index
    @artists = Artist.all
    filter_artist_genres
    filter_artist_agency
    artist_sort
  end

  def show
    render json: Artist.find(params[:id]), status: 200
  end

  def create
    artist = Artist.create(artist_payload)
    if artist.id
      ArtistGenreLinker.link(artist, artist_params[:genres])
      render json: artist, status: 201
    else
      render json: { message: 'Invalid artist parameters.' }, status: 400
    end
  end

  private

  def artist_params
    params.permit(:name, :agency, :genres, :songkick_id, :popularity, :image_url, :spotify_url, :spotify_followers, :spotify_id, :genre)
  end
end

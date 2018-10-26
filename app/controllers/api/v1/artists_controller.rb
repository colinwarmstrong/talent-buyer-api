class Api::V1::ArtistsController < ApplicationController
  def index
    render json: Artist.all, status: 200
  end

  def create
    artist = Artist.create(artist_params)
    link_genres(artist, artist_params[:genres])
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

  def link_genres(artist, genres_list)
    genres_list.split(', ').each do |genre|
      artist.genres.create(name: genre)
    end
  end
end

class Api::V1::ArtistsController < ApplicationController
  before_action :authenticate_buyer!, :buyer_signed_in?

  def index
    @artists = Artist.all
    filter_artist_genres
    filter_artist_agency
    artist_sort
  end

  def create
    artist = Artist.create(artist_payload)
    if artist.id
      link_genres(artist, artist_params[:genres])
      render json: artist, status: 201
    else
      render json: { message: 'Invalid artist parameters.' }, status: 400
    end
  end

  private

  def artist_params
    params.permit(:name, :agency, :genres, :songkick_id, :popularity, :image_url, :spotify_url, :spotify_followers, :spotify_id, :genre)
  end

  def artist_payload
    {
      name: artist_params[:name],
      agency: artist_params[:agency],
      songkick_id: artist_params[:songkick_id],
      popularity: artist_params[:popularity],
      image_url: artist_params[:image_url],
      spotify_url: artist_params[:spotify_url],
      spotify_followers: artist_params[:spotify_followers],
      spotify_id: artist_params[:spotify_id]
    }
  end

  def link_genres(artist, genres_list)
    genres_list.split(', ').each do |genre|
      genre = Genre.find_or_create_by(name: genre.downcase)
      ArtistGenre.create(artist_id: artist.id, genre_id: genre.id)
    end
  end

  def filter_artist_genres
    if params[:genre]
      @artists = Genre.find_by(name: params[:genre].downcase).artists
    end
  end

  def filter_artist_agency
    if params[:agency]
      @artists = @artists.where('lower(agency) = ?', params[:agency].downcase)
    end
  end

  def artist_sort
    if params[:sort] == 'popularity'
      render json: @artists.order(popularity: :desc), status: 200
    elsif params[:sort] == 'followers'
      render json: @artists.order(spotify_followers: :desc), status: 200
    elsif params[:sort] == 'alphabetical'
      render json: @artists.order(Arel.sql('lower(name)')), status: 200
    else
      render json: @artists, status: 200
    end
  end
end

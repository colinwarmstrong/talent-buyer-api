class Api::V1::ArtistsController < ApplicationController
  before_action :authenticate_buyer!, :buyer_signed_in?

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
    artist = Artist.create(artist_params)
    if artist.save
      link_genres(artist, params[:genres])
      render json: artist, status: 201
    else
      render json: { message: 'Invalid artist parameters.' }, status: 400
    end
  end

  private

  def artist_params
    params.permit(:name, :agency, :songkick_id, :popularity, :image_url, :spotify_url, :spotify_followers, :spotify_id, :genre)
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

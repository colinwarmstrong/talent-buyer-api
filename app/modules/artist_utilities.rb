module ArtistUtilities
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
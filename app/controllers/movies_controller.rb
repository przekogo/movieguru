class MoviesController < ApplicationController
  before_action :authenticate_user!, only: [:send_info]

  expose_decorated(:movies) { Movie.all }
  expose(:movie)

  def send_info
    SendMovieInfoJob.perform_async(current_user, movie)
    redirect_to :back, notice: 'Email sent with movie info'
  end

  def export
    file_path = 'tmp/movies.csv'
    SendFileJob.perform_async(current_user, file_path)
    redirect_to root_path, notice: 'Movies exported'
  end

  def get_moviedb_data
    @response = MoviedbApiHandler.get_movie_details(params[:title], ['poster_path', 'vote_average', 'overview'])
    respond_to do |format|
      format.js
    end
  end
end

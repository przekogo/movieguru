class API::V2::MoviesController < API::V1::MoviesController

  expose(:movies) { Movie.all_with_genre_details }
  expose(:movie) { Movie.find_with_genre_details(params[:id]) }

end